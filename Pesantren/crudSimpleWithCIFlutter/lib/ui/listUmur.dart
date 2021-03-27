import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mentoringmasalam2/repository/user_repository.dart';
import 'package:mentoringmasalam2/models/user_model.dart';

class ListUmur extends StatefulWidget {
  final int age;
  ListUmur({this.age});

  @override
  _ListUmurState createState() => _ListUmurState();
}

class _ListUmurState extends State<ListUmur> {
  int get age => widget.age;
  List<User> listUser = [];

  void initial() async {
    List<User> result = await userRepo.getDataUserByAge(age);
    if (result != null) {
      setState(() {
        listUser = result;
        log("user : ${jsonEncode(result.toList())}");
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
      body: SafeArea(
        child: Container(
          child: ListView.builder(
              itemCount: listUser.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: <Widget>[
                        Text("Nama :  ${listUser[index].name}"),
                        Text("Umur :  ${listUser[index].age}"),
                        Text("Pekerjaan :  ${listUser[index].jobs}"),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
