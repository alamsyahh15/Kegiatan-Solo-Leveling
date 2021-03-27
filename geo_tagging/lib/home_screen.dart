import 'dart:io';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  File _file;
  final picker = ImagePicker();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _file = File(pickedFile.path);
        needRotation(_file);
      } else {
        print('No image selected.');
      }
    });
  }

  needRotation(File path) async {
    var tags = await readExifFromFile(path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geo Tagging"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16),
              color: Colors.red,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height / 4,
              child: _file != null
                  ? Image.file(
                      _file,
                      fit: BoxFit.cover,
                    )
                  : Text(""),
            ),
            RaisedButton(
                child: Text("Take Image"),
                onPressed: () {
                  getImage();
                }),
          ],
        ),
      ),
    );
  }
}
