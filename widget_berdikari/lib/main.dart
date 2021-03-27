import 'dart:io';

import 'package:flutter/material.dart';
import 'package:widget_berdikari/contain_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  File image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            image != null ? Image.file(image) : Text("Image Kosong"),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              child: Text("Show Sheet"),
              onPressed: () {
                showSheet();
              },
            ),
            RaisedButton(
              child: Text("Show Dialog"),
              onPressed: () {
                photoDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  photoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Take Image"),
        content: ContainDialog(
          onChange: (dataImg) {
            setState(() {
              image = dataImg;
            });
          },
        ),
      ),
    );
  }

  showSheet() {
    key.currentState.showBottomSheet(
      (context) => ContaineSheet(
        onChange: (value) {
          print("Value $value");
        },
      ),
    );
  }
}

class ContaineSheet extends StatefulWidget {
  final Function(String value) onChange;

  const ContaineSheet({Key key, this.onChange}) : super(key: key);
  @override
  _ContaineSheetState createState() => _ContaineSheetState();
}

class _ContaineSheetState extends State<ContaineSheet> {
  List<String> nameStaffList = ["Rizal", "Alam", "Daput", "Wahyu", "Wahyu"];
  String valueStaff;
  @override
  Widget build(BuildContext context) {
    nameStaffList = nameStaffList.toSet().toList();
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          DropdownButton(
            value: valueStaff,
            hint: Text("Pilih Staff"),
            isExpanded: true,
            items: nameStaffList.map((e) {
              return DropdownMenuItem(
                child: Text(e),
                value: e,
              );
            }).toList(),
            onChanged: (val) {
              setState(() {
                valueStaff = val;
                widget.onChange(val);
              });
            },
          ),
        ],
      ),
    );
  }
}
