import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_flutter_chat_app/app.dart';
import 'package:my_flutter_chat_app/misc/list_orders.dart';

Future<void> main() async {
  // Firebase初期化
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDYGd_NaMlbOGGQr-Mr09GDFoTf_bd10wo",
      authDomain: "simple-fucking-chat-app.firebaseapp.com",
      projectId: "simple-fucking-chat-app",
      storageBucket: "simple-fucking-chat-app.appspot.com",
      messagingSenderId: "920453696375",
      appId: "1:920453696375:web:59decf1087bbb141a76f72",
      measurementId: "G-4L2W27FJ17",
    ),
  );
  // アプリ起動
  // Riverpodでデータを受け渡しできる状態にする
  runApp(
    ProviderScope(child: ChatApp()),
  );
}
