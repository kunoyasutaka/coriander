import 'package:coriander/domain/book.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  final Book book;

  AddBookPage({this.book});

  @override
  Widget build(BuildContext context) {
    final bool isUpdata = (book != null);
    final TextEditingController textEditingController = TextEditingController();

    if (isUpdata) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdata ? "本を編集" : "本を追加"),
            ),
            body: Consumer<AddBookModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 100.0,
                        height: 160.0,
                        child: InkWell(
                          onTap: () async {
                            await model.showImagePicker();
                          },
                          child: model.imageFile != null
                              ? Image.file(model.imageFile)
                              : Container(
                                  color: Colors.grey,
                                ),
                        ),
                      ),
                      TextField(
                        controller: textEditingController,
                        onChanged: (text) {
                          model.bookTitle = text;
                        },
                      ),
                      ElevatedButton(
                          child: Text(isUpdata ? "更新する" : "追加する"),
                          onPressed: () async {
                            model.startLoading();
                            if (isUpdata) {
                              await updateBook(model, context);
                            } else {
                              await addBook(model, context);
                            }
                            model.endLoading();
                          }),
                    ],
                  ),
                );
              },
            ),
          ),
          Consumer<AddBookModel>(
            builder: (context, model, child) {
              return model.isLoading
                  ? Container(
                      color: Colors.grey.withOpacity(0.7),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox();
            },
          )
        ],
      ),
    );
  }

  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      await model.addBookToFirebase();
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("保存しました"),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e.toString()),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      await model.upDataBook(book);
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("更新しました"),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
      Navigator.of(context).pop();
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e.toString()),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }
}
