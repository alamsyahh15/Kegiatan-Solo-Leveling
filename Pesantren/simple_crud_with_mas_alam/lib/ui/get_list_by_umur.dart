import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_crud_with_mas_alam/model/user_model.dart';
import 'package:simple_crud_with_mas_alam/repository/user_respository.dart';

class GetListByUmur extends StatefulWidget {
  GetListByUmur({this.umur});
  final int umur;
  @override
  _GetListByUmurState createState() => _GetListByUmurState();
}

class _GetListByUmurState extends State<GetListByUmur> {
  int get _umur => widget.umur;
  List<User> listUser = [];
  // , listBackUp = [];
  void initial() async {
    List<User> result = await userRepository.getDataUserByAge(_umur);
    if (result != null) {
      // List<User> result = awaot userRepository.getDataUser();\
      setState(() {
        listUser = result;
        // listBackUp = result;
        log("user ${jsonEncode(result.toList())}");
      });
    }
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
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: listUser.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text('Nama ; ${listUser[index].nama}'),
                        Text('Nama ; ${listUser[index].umur}'),
                        Text('Nama ; ${listUser[index].jobs}')
                      ],
                    ),
                  ));
            },
          ),
        ),
      ),
    );
  }
}
