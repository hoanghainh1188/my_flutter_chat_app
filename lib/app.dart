import 'package:flutter/material.dart';
import 'package:my_flutter_chat_app/auth/login_page.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // アプリ名
      title: 'チャットアプリ',
      // テーマ
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      // ログイン画面を表示
      home: const LoginPage(),
    );
  }
}
