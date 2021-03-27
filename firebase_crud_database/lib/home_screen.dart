import 'dart:developer';

import 'package:firebase_crud_database/database_helper.dart';
import 'package:firebase_crud_database/task_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  List<TaskModel> listTask = [];
  DatabaaseHelper dbHelper = DatabaaseHelper();
  TaskModel dataTask = TaskModel(
    completed: false,
    subject: "Sample Subjet",
    task: "Task1",
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var dbRef = database.reference().child("Task");
    dbRef.once().then((snapshot) {
      if (snapshot != null) {
        listTask.clear();
        dbRef.onChildAdded.listen((event) {
          setState(() {
            listTask.add(TaskModel.fromSnapshot(event.snapshot));
          });
        });
        dbRef.onChildChanged.listen((event) {
          listTask.clear();
          dbRef.onChildAdded.listen((event) {
            setState(() {
              listTask.add(TaskModel.fromSnapshot(event.snapshot));
            });
          });
        });
        dbRef.onChildRemoved.listen((event) {
          setState(() {
            listTask.removeWhere((e) => e.key == event.snapshot.key);
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: listTask.length,
          itemBuilder: (BuildContext context, int index) {
            TaskModel data = listTask[index];
            return InkWell(
              onLongPress: () async {
                await dbHelper.delete(context, data);
              },
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.amber.withOpacity(0.5),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            "${data.subject}",
                            style: TextStyle(
                              fontWeight: data.completed
                                  ? FontWeight.w300
                                  : FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text("${data.task}"),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          dbHelper.addTask(context, dataTask);
        },
      ),
    );
  }
}
