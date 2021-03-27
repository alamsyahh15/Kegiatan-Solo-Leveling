import 'dart:convert';

import 'package:book_app/constant/categoryModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_app/constant/constantFile.dart';
import 'package:http/http.dart' as http;

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  final list = new List<CategoryModel>();
  var loading = false;
  Future _lihatData() async {
    list.clear();
    setState(() {
      loading = true;
    });
    final response = await http.get(BaseUrl.getCategory);
    if (response.contentLength == 2) {
    } else {
      final data = jsonDecode(response.body);
      data.forEach((api) {
        final ab = new CategoryModel(
          api['id_category'],
          api['name_category'],
        );
        list.add(ab);
      });

      setState(() {
        loading = false;
      });
    }
  }

  _delete(String id_category) async {
    final response = await http
        .post(BaseUrl.deleteCategory, body: {"id_category": id_category});

    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];

    if (value == 1) {
      _lihatData();
    } else {
      print(pesan);
    }
  }

  dialogDelete(String id_category) {
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
                            _delete(id_category);
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
          title: Text('List Category Book'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: loading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final x = list[i];

                  return Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Card(
                      child: ListTile(
                        subtitle: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 3),
                                        child: Text(
                                          'Book Category : ' + x.name_category,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
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
                  );
                },
              ));
  }
}
