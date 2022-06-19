import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;

  //追加処理
  Future<void> addBook() async {
    if (title == null || title == "") {
      throw '本のタイトルが入力されていません';
    }

    if (author == null || author!.isEmpty) {
      throw '著者が入力されていません';
    }

    //fire storeに追加
    await FirebaseFirestore.instance.collection('books').add(
      {
        'title': title,
        'author': author,
      },
    );
  }
}
