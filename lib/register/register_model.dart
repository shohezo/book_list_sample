import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterModel extends ChangeNotifier {
  final titleController = TextEditingController();
  final authorController = TextEditingController();

  String? email;
  String? password;

  bool isLoading =false;

  void startLoading(){
    isLoading = true;
    notifyListeners();
  }

  void endLoading(){
    isLoading = false;
    notifyListeners();
}

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  //追加処理
  Future<void> signup() async {
    this.email = titleController.text;
    this.password = authorController.text;

    if (email != null && password != null) {
      //firebaseAuthでユーザー作成
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);
      final user = userCredential.user;
      if (user != null) {
        final uid = user.uid;

        //fire storeに追加
        final doc = await FirebaseFirestore.instance.collection('users').doc(uid);

            await doc.set(
          {
            'uid': uid,
            'email': email, //DBにパスワードは入れないほうがいい。ユーザーしか見れないようにする。
          },
        );
      }
    }
  }
}
