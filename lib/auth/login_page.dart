import 'package:flutter/material.dart';
import 'package:my_flutter_chat_app/chat/chat_page.dart';

// ログイン画面用Widget
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              // チャット画面に遷移＋ログイン画面を破棄
              onPressed: () async {
                await Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) {
                    return const ChatPage();
                  }),
                );
              },
              child: const Text('ログイン'),
            ),
          ],
        ),
      ),
    );
  }
}
