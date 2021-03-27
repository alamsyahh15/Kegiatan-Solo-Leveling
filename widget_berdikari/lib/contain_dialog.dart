import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ContainDialog extends StatefulWidget {
  final Function(File dataImg) onChange;

  const ContainDialog({Key key, this.onChange}) : super(key: key);
  @override
  _ContainDialogState createState() => _ContainDialogState();
}

class _ContainDialogState extends State<ContainDialog> {
  File file;
  takeImage() async {
    /// Ambil Gambar
    PickedFile result =
        await ImagePicker().getImage(source: ImageSource.camera);

    /// Set Gambar
    if (result != null) {
      setState(() {
        file = File(result.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              takeImage();
            },
            child: file != null ? Image.file(file) : Text("File Kosong"),
          ),
          RaisedButton(
            child: Text("Submit"),
            color: Colors.green,
            onPressed: () {
              Navigator.pop(context);
              widget.onChange(file);
            },
          )
        ],
      ),
    );
  }
}
