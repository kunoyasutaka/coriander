import 'package:coriander/presentation/add_book/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetBooks(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("本一覧"),
        ),
        body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
                .map((book) => ListTile(
                      title: Text(book.title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddBookPage(book: book),
                                  fullscreenDialog: true));
                          model.fetBooks();
                        },
                      ),
                    ))
                .toList();
            return ListView(
              children: listTiles,
            );
          },
        ),
        floatingActionButton: Consumer<BookListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddBookPage(),
                        fullscreenDialog: true));
                model.fetBooks();
              },
            );
          },
        ),
      ),
    );
  }
}
