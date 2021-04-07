import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String kboyText = "KBOYさんじゃないよ";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text("コリアンダー"),
        ),
        body: Center(
          child: Column(
            children: [
              Text(
                kboyText,
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              ElevatedButton(
                child: Text("ボタン"),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
