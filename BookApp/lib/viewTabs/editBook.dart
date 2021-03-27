import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:book_app/constant/constantFile.dart';
import 'package:book_app/constant/bookModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';
import 'package:path/path.dart' as path;

class EditBook extends StatefulWidget {
  final BookModel model;
  final VoidCallback reload;

  EditBook(this.model, this.reload);

  @override
  _EditBookState createState() => _EditBookState();
}

class _EditBookState extends State<EditBook> {
  final _key = new GlobalKey<FormState>();

  File _imageFile;
  String title, category, description, link_book, id_users;
  TextEditingController txtTitle, txtContent, txtLinkBook, txtDescription;

  setup() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id_users = preferences.getString("id_users");
    });
    txtTitle = TextEditingController(text: widget.model.title);
    txtContent = TextEditingController(text: widget.model.category);
    txtDescription = TextEditingController(text: widget.model.description);
    txtLinkBook = TextEditingController(text: widget.model.link_book);
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      submit();
    } else {}
  }

  submit() async {
    //3.3 Edit gambar
    try {
      var uri = Uri.parse(BaseUrl.editBook);

      print("Data Id Book ${widget.model.id_book}");
      var request = http.MultipartRequest("POST", uri);

      //--------------------------------------------------------------
      request.fields['title'] = title;
      request.fields['category'] = category;
      request.fields['description'] = description;
      request.fields['link_book'] = link_book;
      request.fields['id_users'] = id_users;
      request.fields['id_book'] = widget.model.id_book;

      var stream =
          http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
      var length = await _imageFile.length();

      request.files.add(http.MultipartFile("image", stream, length,
          filename: path.basename(_imageFile.path)));

      var response = await request.send();
      var res = await response.stream.transform(utf8.decoder).join();

      print("Response $res");
      if (response.statusCode > 2) {
        print("image Upload");
        setState(() {
          widget.reload();
          Navigator.pop(context);
        });
      } else {
        print("image failed");
      }
    } catch (e) {
      debugPrint("Error $e");
    }
  }

  _pilihGallery() async {
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920);
    setState(() {
      _imageFile = image;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _key,
        child: ListView(
          padding: EdgeInsets.all(15),
          children: [
            Container(
              width: double.infinity,
              child: InkWell(
                onTap: () {
                  _pilihGallery();
                },
                child: _imageFile == null
                    ? Image.network(BaseUrl.insertImage + widget.model.image)
                    : Image.file(
                        _imageFile,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
            TextFormField(
              controller: txtTitle,
              onSaved: (e) => title = e,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: txtContent,
              onSaved: (e) => category = e,
              decoration: InputDecoration(labelText: 'Category'),
            ),
            TextFormField(
              controller: txtDescription,
              onSaved: (e) => description = e,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: txtLinkBook,
              onSaved: (e) => link_book = e,
              decoration: InputDecoration(labelText: 'Link Book'),
            ),
            SizedBox(
              height: 5,
            ),
            MaterialButton(
              onPressed: () {
                check();
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
