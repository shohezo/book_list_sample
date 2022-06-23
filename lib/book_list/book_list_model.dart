import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../domain/book.dart';

class BookListModel extends ChangeNotifier {
  //変数の定義
  final _usersCollection =
      FirebaseFirestore.instance.collection('books');

  List<Book>? books;

  //取得処理
  void fetchBookList() async {
    final QuerySnapshot snapshot = await _usersCollection.get();
    final List<Book> books = snapshot.docs.map((DocumentSnapshot document) {
      //ドキュメント型からBookの型に変換
      Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
      final String id = document.id;
      final String title = data['title'];
      final String author = data['author'];
      return Book(id,title, author);
    }).toList();

    this.books = books;
    notifyListeners();
  }

  //削除処理
  Future delete(Book book) {
    return FirebaseFirestore.instance.collection('books').doc(book.id).delete();
  }
}
