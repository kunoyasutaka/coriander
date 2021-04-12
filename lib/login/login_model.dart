import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String mail = "";
  String password = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future loginModel() async {
    if (mail.isEmpty) {
      throw ("メールアドレスを入力して下さい");
    }

    if (password.isEmpty) {
      throw ("パスワードを入力して下さい");
    }
    await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
  }
}
