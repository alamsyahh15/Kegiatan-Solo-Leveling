import 'dart:developer';
import 'dart:io';
import 'dart:io' as Io;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:saving_image_local/db_helper.dart';
import 'package:saving_image_local/note_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NoteModel> listNote = [];

  Future addNote(NoteModel note, File file) async {
    var resPath = await insertImage(file);
    note.image = resPath;
    Database db = await dbHelper.database;
    var res = await db.insert('note_table', note.toJson());
  }

  Future getData() async {
    Database db = await dbHelper.database;
    List tempList = await db.query('note_table');
    log("TempList $tempList");
    if ((tempList?.length ?? 0) > 0) {
      tempList.forEach((element) {
        setState(() {
          listNote.add(NoteModel.fromJson(element));
        });
      });
    }
  }

  Future<String> insertImage(File image) async {
    String nameImage;
    if (image != null) {
      var dir = Directory('/storage/emulated/0');
      if (dir.existsSync()) {
        await Io.Directory('${dir.path}/Daput/ImagesData')
            .create(recursive: true);
      }
      var existDir = Directory('${dir.path}/Daput/ImagesData');
      var filePath = "${existDir.path}/Image_${basename(image.path)}";
      var res = await image.copy(filePath);
      nameImage = filePath;
    }
    return nameImage;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: listNote.length,
        itemBuilder: (BuildContext context, int index) {
          NoteModel data = listNote[index];
          return Card(
            child: Container(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text("${data.note}"),
                leading: data.image == null
                    ? Container(
                        height: 30,
                        width: 30,
                        color: Colors.grey,
                      )
                    : Image.file(
                        File(data.image),
                        width: 30,
                        height: 30,
                      ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          PickedFile pick =
              await ImagePicker().getImage(source: ImageSource.camera);
          if (pick != null) {
            addNote(NoteModel(note: "SAmple"), File(pick.path));
          }
        },
      ),
    );
  }
}
