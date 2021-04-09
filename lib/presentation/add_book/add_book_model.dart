import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:flutter/material.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = "";

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ("タイトルを入力して下さい");
    }

    FirebaseFirestore.instance.collection("books").add({
      "title": bookTitle,
      "createAt": Timestamp.now(),
    });
  }

  Future upDataBook(Book book) async {
    final document =
        FirebaseFirestore.instance.collection("book").doc(book.documentID);
    await document.update({
      "title": bookTitle,
      "updateAt": Timestamp.now(),
    });
  }
}
