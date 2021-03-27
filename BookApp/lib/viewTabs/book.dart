import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_app/constant/constantFile.dart';
import 'package:book_app/constant/bookModel.dart';
import 'package:book_app/viewTabs/addBook.dart';
import 'package:http/http.dart' as http;
import 'package:book_app/viewTabs/detail.dart';
import 'package:book_app/viewTabs/editBook.dart';

import '../constant/bookModel.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  final list = new List<BookModel>();
  var loading = false;
  Future _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.detailBook);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);

      data.forEach((api) {
        final ab = new BookModel(
          api['id_book'],
          api['image'],
          api['title'],
          api['category'],
          api['description'],
          api['date_publish'],
          api['link_book'],
          api['id_users'],
          api['username'],
        );
        list.add(ab);
      });
      setState(() {
        loading = false;
      });
    }
  }

  _delete(String id_book) async {
    try {
      final response =
          await http.post(BaseUrl.deleteBook, body: {"id_book": id_book});

      print("Response Data ${jsonDecode(response.body)}");
      final data = jsonDecode(response.body);
      int value = data['value'];
      String pesan = data['message'];

      if (value == 1) {
        _lihatData();
      } else {
        print(pesan);
      }
    } catch (e) {
      print("Exception Data : $e");
    }
  }

  dialogDelete(String id_book) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              height: 120,
              child: ListView(
                padding: EdgeInsets.all(10),
                children: [
                  Text(
                    "Apakah Data ini ingin di hapus ?",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text('No')),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                          onTap: () {
                            _delete(id_book);
                          },
                          child: Text('Yes'))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _lihatData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('List Book'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddBook()));
          },
          child: Icon(Icons.add),
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];
                  var desc = x.description;
                  var desk;
                  _desc() {
                    if (desc.length > 74) {
                      desk = desc.substring(0, 75);
                    } else {
                      desk = desc;
                    }
                    return desk;
                  }

                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => DetailBook(x, _lihatData)));
                      },
                      child: Card(
                        child: ListTile(
                          subtitle: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: Image.network(
                                      BaseUrl.insertImage + x.image,
                                      width: 130,
                                      height: 110,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 3),
                                          child: Text(
                                            "${x.title} ID : ${x.id_book}",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'Kategori : ' + x.category,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          _desc(),
                                          style: TextStyle(
                                            fontSize: 13,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8),
                                          child: Text(
                                            'Tanggal Publish : ' +
                                                x.date_publish,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                icon: Icon(Icons.edit),
                                                color: Colors.blueAccent,
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              EditBook(x,
                                                                  _lihatData)));
                                                }),
                                            IconButton(
                                                icon: Icon(Icons.delete),
                                                color: Colors.blueAccent,
                                                onPressed: () {
                                                  dialogDelete(x.id_book);
                                                }),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ));
  }
}
