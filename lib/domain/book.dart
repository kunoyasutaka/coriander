import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  String title;
  String documentID;
  String imageURL;

  Book(DocumentSnapshot doc) {
    documentID = doc.id;
    title = doc.data()["title"];
    imageURL = doc.data()["imageURL"];
  }
}
