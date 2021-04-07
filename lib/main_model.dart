import 'package:flutter/cupertino.dart';

class MainModel extends ChangeNotifier {
  String kboyText = "KBOYさん";

  void changeKboyText(){
    kboyText = "KBOYさんかっこいい";
    notifyListeners();
  }
}