import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_chat_app/auth/login_page.dart';
import 'package:my_flutter_chat_app/chat/add_post_page.dart';

// チャット画面用Widget
class ChatPage extends StatelessWidget {
  // 引数からユーザー情報を受け取れるようにする
  const ChatPage(this.user, {super.key});

  // ユーザー情報
  final User? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                // ログアウト処理
                // 内部で保持しているログイン情報等が初期化される
                await FirebaseAuth.instance.signOut();
                // ログイン画面に遷移＋チャット画面を破棄
                // ignore: use_build_context_synchronously
                await Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                }));
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: Text('ログイン情報：${user!.email}'),
          ),
          Expanded(
            // 非同期処理の結果を元にWidgetを作れる
            child: StreamBuilder<QuerySnapshot>(
              // 投稿メッセージ一覧を取得（非同期処理）
              // 投稿日時でソート
              stream: FirebaseFirestore.instance
                  .collection('posts')
                  .orderBy('date')
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot<Object?>> snapshot) {
                // データが取得できた場合
                if (snapshot.hasData) {
                  final List<DocumentSnapshot> documents = snapshot.data!.docs;
                  return ListView(
                    children: documents.map((document) {
                      return Card(
                        child: ListTile(
                          title: Text(document['text']),
                          subtitle: Text(document['email']),

                          // 自分の投稿メッセージの場合は削除ボタンを表示
                          trailing: document['email'] == user?.email
                              ? IconButton(
                                  onPressed: () async {
                                    // 投稿メッセージのドキュメントを削除
                                    await FirebaseFirestore.instance
                                        .collection('posts')
                                        .doc(document.id)
                                        .delete();
                                  },
                                  icon: const Icon(Icons.delete))
                              : null,
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(
                  child: Text('読込中...'),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          // 投稿画面に遷移
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return AddPostPage(user!);
            }),
          );
        },
      ),
    );
  }
}
