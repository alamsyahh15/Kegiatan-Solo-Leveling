import 'package:firebase_crud_database/task_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DatabaaseHelper {
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future addTask(context, TaskModel dataTask) async {
    progressDialog(context);
    await database.reference().child("Task").push().set(dataTask.toJson());
    Navigator.pop(context);
  }

  Future update(context, TaskModel dataTask) async {
    progressDialog(context);
    await database
        .reference()
        .child("Task")
        .child(dataTask.key)
        .set(dataTask.toJson());
    Navigator.pop(context);
  }

  Future delete(context, TaskModel dataTask) async {
    progressDialog(context);
    await database.reference().child("Task").child(dataTask.key).remove();
    Navigator.pop(context);
  }
}

progressDialog(context) {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black45.withOpacity(0.5),
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: CircularProgressIndicator(),
      );
    },
  );
}
