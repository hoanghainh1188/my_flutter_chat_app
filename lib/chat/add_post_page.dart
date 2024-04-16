import 'package:flutter/material.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('チャット投稿'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 1つ前の画面に戻る
            Navigator.of(context).pop();
          },
        child: const Text('戻る')),
      ),
    );
  }
}