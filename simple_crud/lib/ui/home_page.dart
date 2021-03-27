import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_crud/model/user_model.dart';
import 'package:simple_crud/repository/user_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> listUser = [], listBackup = [];

  /// Method initial = akan dipanggil pertama kali membuka screen
  /// Home Page
  void initial() async {
    /// Memanggil function get data user dan memasukannya kedalam variable
    List<User> result = await userRepo.getDataUser();
    if (result != null) {
      setState(() {
        // => Set result yang didapat ke dalam variable listUser diatas
        listUser = result;
        listBackup.addAll(listUser);
        log("User ${jsonEncode(result.toList())}");
      });
    }
  }

  void search(String inputQuery) {
    /// Jika nilai yang yang di inputkan kosong maka kita kembalikan
    /// data backup ke listUser
    listUser = listBackup;
    if (inputQuery.isNotEmpty) {
      /// Jika nilai yang yang di inputkan rdk kosong maka kita filter
      /// data listUser sesuai dengan kata kunci yang inputkan lalu kita set ke
      /// dalam listUser itu sendiri
      String query = inputQuery.toLowerCase();
      listUser = listUser
          .where((e) =>
              e.name.toLowerCase().contains(query) ||
              e.age.toLowerCase().contains(query))
          .toList();
    }
    setState(() {});
  }

  filterByCategory() {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheet(
        onClosing: () {},
        builder: (context) => Container(
          child: Column(
            children: [
              RaisedButton(
                child: Text("Filter By 19yo"),
                onPressed: () {
                  search("19");
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text("Filter By 20yo"),
                onPressed: () {
                  search("20");
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text("Filter By 21yo"),
                onPressed: () {
                  search("21");
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text("Filter By 22yo"),
                onPressed: () {
                  search("22");
                  Navigator.pop(context);
                },
              ),
              RaisedButton(
                child: Text("Filter By 23yo"),
                onPressed: () {
                  search("23");
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  refresh() {
    setState(() {
      listUser.clear();
      listBackup.clear();
    });
    initial();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.filter_1),
            onPressed: () {
              filterByCategory();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              refresh();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            TextFormField(
              onChanged: (value) {
                search(value);
              },
            ),
            SizedBox(height: 16),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: listUser?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Nama : ${listUser[index].name}"),
                            Text("Umur : ${listUser[index].age}"),
                            Text("Pekerjaan : ${listUser[index].jobs}"),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
