import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_chat_app/model/app_states.dart';

// チャット投稿用データ
class AddPostPage extends ConsumerWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // ユーザー情報を受け取る
    final User user = watch(userProvider).state!;
    final messageText = watch(messageProvider).state;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('チャット投稿'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(32),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 投稿メッセージの入力
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: '投稿メッセージ',
                  ),
                  // 複数行のテキスト入力
                  keyboardType: TextInputType.multiline,
                  // 最大3行
                  maxLines: 3,
                  onChanged: (String value) {
                   context.read(messageProvider).state = value;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text('投稿'),
                    onPressed: () async {
                      // 現在の日時を取得
                      final date = DateTime.now().toIso8601String();
                      // 現在のユーザーを取得
                      final email = user.email;
                      // 投稿メッセージ用ドキュメント作成
                      await FirebaseFirestore.instance
                          .collection('posts')
                          .doc()
                          .set({
                        'text': messageText,
                        'email': email,
                        'date': date
                      });
                      // 1つ前の画面に戻る
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
