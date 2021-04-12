import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coriander/domain/book.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = "";
  final CollectionReference books =
      FirebaseFirestore.instance.collection("books");
  final storage = FirebaseStorage.instance;
  File imageFile;
  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw ("タイトルを入力して下さい");
    }

    final imageURL = await _upLoadImage();

    books.add({
      "title": bookTitle,
      "imageURL": imageURL,
      "createAt": Timestamp.now(),
    });
  }

  Future upDataBook(Book book) async {
    final document = books.doc(book.documentID);
    final imageURL = await _upLoadImage();

    await document.update({
      "title": bookTitle,
      "imageURL": imageURL,
      "updateAt": Timestamp.now(),
    });
  }

  Future<String> _upLoadImage() async {
    TaskSnapshot snapshot =
        await storage.ref().child("books/$bookTitle").putFile(imageFile);
    final String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }
}
