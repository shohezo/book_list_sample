import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  //変数の定義
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  List<Book>? books;

  //取得処理
  void fetchBookList() {
    _usersStream.listen((QuerySnapshot snapshot) {

      final List<Book> books = snapshot.docs.map((DocumentSnapshot document) { //ドキュメント型からBookの型に変換
        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
        final String title = data['title'];
        final String author = data['author'];
        return Book(title, author);
      }).toList();

      this.books = books;
      notifyListeners();
    });
  }
}
