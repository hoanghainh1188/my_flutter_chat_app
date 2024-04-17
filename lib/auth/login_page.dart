import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_chat_app/chat/chat_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_flutter_chat_app/model/app_states.dart';

// ログイン画面用データ
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    // Providerから値を受け取る
    final infoText = watch(infoTextProvider).state;
    final email = watch(emailProvider).state;
    final password = watch(passwordProvider).state;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // メールアドレスの入力
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'メールアドレス'),
                    onChanged: (String value) {
                      // Providerから値を更新
                      context.read(emailProvider).state = value;
                    },
                  ),
                  // パスワードの入力
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'パスワード'),
                    onChanged: (value) {
                      // Providerから値を更新
                      context.read(passwordProvider).state = value;
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Text(infoText),
                  ),
                  SizedBox(
                    width: double.infinity,
                    // ユーザー登録ボタン
                    child: ElevatedButton(
                      child: const Text('ユーザー登録'),
                      onPressed: () async {
                        try {
                          final FirebaseAuth auth = FirebaseAuth.instance;
                          final result =
                              await auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                          // ユーザー情報を更新
                          // ignore: use_build_context_synchronously
                          context.read(userProvider).state = result.user;
                          // ユーザー登録に成功した場合
                          // チャット画面に遷移し、ログインを破棄
                          // ignore: use_build_context_synchronously
                          await Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) {
                              return const ChatPage(/*result.user*/);
                            }),
                          );
                        } catch (e) {
                          // ユーザー登録に失敗した場合
                          // ignore: use_build_context_synchronously
                          context.read(infoTextProvider).state =
                              "登録に失敗しました：${e.toString()}";
                        }
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: double.infinity,
                    // ログインボタン
                    child: OutlinedButton(
                        onPressed: () async {
                          try {
                            // メールアドレスとパスワードでログイン
                            final FirebaseAuth auth = FirebaseAuth.instance;
                            final result =
                                await auth.signInWithEmailAndPassword(
                                    email: email, password: password);
                            // ユーザー情報を更新
                            context.read(userProvider).state = result.user;
                            // ログインに成功した場合
                            // チャット画面に遷移し、ログイン画面を破棄
                            // ignore: use_build_context_synchronously
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                                return const ChatPage(/*result.user*/);
                              }),
                            );
                          } catch (e) {
                            // ログインに失敗した場合
                            context.read(infoTextProvider).state =
                                "登録に失敗しました：${e.toString()}";
                          }
                        },
                        child: const Text('ログイン')),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
