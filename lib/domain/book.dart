import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String title;
  String documentID;

  Book(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc.data()["title"];
  }
}
