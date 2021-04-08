import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/book.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  Future fetBooks() async {
    //firestoreのコレクションを取得
    final docs = await FirebaseFirestore.instance.collection('books').get();

    //docの値のtitleを取得してbooksに配列として格納
    final books = docs.docs.map((doc) => Book(doc["title"])).toList();

    this.books = books;
    notifyListeners();
  }
}
