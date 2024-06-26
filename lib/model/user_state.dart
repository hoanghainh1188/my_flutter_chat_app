import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// 更新可能なデータ
class UserState extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user){
    _user = user;
    notifyListeners();
  }
}