import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/widget.dart';

Future<File> takeImage(context) async {
  File file;
  await showModalBottomSheet(
    context: context,
    builder: (context) => BottomSheet(
      onClosing: () {},
      builder: (context) => Container(
        padding: EdgeInsets.all(medium),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: widthScreen(context),
              height: 45,
              // ignore: deprecated_member_use
              child: FlatButton.icon(
                  onPressed: () async {
                    progressDialog(context);
                    PickedFile res = await ImagePicker()
                        .getImage(source: ImageSource.camera, imageQuality: 50);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (res != null) {
                      file = File(res.path);
                    }
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text("Camera")),
            ),
            SizedBox(height: medium),
            Container(
              width: widthScreen(context),
              height: 45,
              // ignore: deprecated_member_use
              child: FlatButton.icon(
                  onPressed: () async {
                    progressDialog(context);
                    PickedFile res = await ImagePicker().getImage(
                        source: ImageSource.gallery, imageQuality: 50);
                    Navigator.pop(context);
                    Navigator.pop(context);
                    if (res != null) {
                      file = File(res.path);
                    }
                  },
                  icon: Icon(Icons.photo),
                  label: Text("Gallery")),
            )
          ],
        ),
      ),
    ),
  );
  return file;
}
