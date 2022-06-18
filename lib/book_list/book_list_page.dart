import 'package:book_list_sample/book_list/book_list_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/book.dart';

class BookListPage extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('books').snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
          centerTitle: true,
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: null,
          tooltip: 'インクリメント',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
