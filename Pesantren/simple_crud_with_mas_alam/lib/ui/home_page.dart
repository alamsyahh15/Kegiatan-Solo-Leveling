import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_crud_with_mas_alam/model/user_model.dart';
import 'package:simple_crud_with_mas_alam/repository/user_respository.dart';
import 'package:simple_crud_with_mas_alam/ui/get_list_by_umur.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> listUser = [], listBackUp = [];

  void initial() async {
    List<User> result = await userRepository.getDataUser();
    if (result != null) {
      // List<User> result = awaot userRepository.getDataUser();\
      setState(() {
        listUser = result;
        listBackUp = result;
        log("user ${jsonEncode(result.toList())}");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Builder(
            builder: (context) => FlatButton(
              onPressed: () {
                showModalBottomSheet(
                  builder: (context) => BottomSheet(
                    builder: (BuildContext context) {
                      return Container(
                        child: Column(
                          children: [
                            RaisedButton(
                              child: Text('19'),
                              onPressed: () {
                                Navigator.pop(context);
                                search("19");
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return GetListByUmur(umur: 19);
                                // }));
                              },
                            ),
                            RaisedButton(
                              child: Text('20'),
                              onPressed: () {
                                Navigator.pop(context);
                                search("20");
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return GetListByUmur(umur: 20);
                                // }));
                              },
                            ),
                            RaisedButton(
                              child: Text('21'),
                              onPressed: () {
                                Navigator.pop(context);
                                search("21");
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return GetListByUmur(umur: 21);
                                // }));
                              },
                            ),
                            RaisedButton(
                              child: Text('22'),
                              onPressed: () {
                                Navigator.pop(context);
                                search("22");
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return GetListByUmur(umur: 22);
                                // }));
                              },
                            ),
                            RaisedButton(
                              child: Text('23'),
                              onPressed: () {
                                Navigator.pop(context);
                                search("23");
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) {
                                //   return GetListByUmur(umur: 23);
                                // }));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    onClosing: () {},
                  ),
                  context: context,
                );
              },
              child: Icon(Icons.list),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) => search(value),
            ),
            Expanded(
                child: Container(
              child: ListView.builder(
                itemCount: listBackUp.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('Nama ; ${listBackUp[index].nama}'),
                            Text('Nama ; ${listBackUp[index].umur}'),
                            Text('Nama ; ${listBackUp[index].jobs}')
                          ],
                        ),
                      ));
                },
              ),
            )),
          ],
        ),
      ),
      // asa
    );
  }

  /// Bisa gunakan fungsi method search sebelum nya dengan menambahkan filter or by umur
  /// Atau bisa buat method beru dengan method seperti ini

  filterByAges(String inputQuery) {
    listBackUp = listUser;
    if (inputQuery.isNotEmpty) {
      listBackUp = listUser
          .where((element) => element.umur.toLowerCase() == inputQuery)
          .toList();
    }
    setState(() {});
  }

  search(String inputQuery) {
    if (inputQuery.isEmpty) {
      // listUser = listBackUp;
      listBackUp = listUser;
    } else {
      String query = inputQuery.toLowerCase();
      listBackUp = listUser
          .where((element) =>
              element.nama.toLowerCase().contains(query) ||
              element.umur.toLowerCase() == inputQuery)
          .toList();
    }
    setState(() {});
  }
}
