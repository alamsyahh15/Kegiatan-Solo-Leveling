import 'package:firebase_database/firebase_database.dart';

class TaskModel {
  TaskModel({
    this.key,
    this.subject,
    this.task,
    this.completed,
  });

  String key;
  String subject;
  String task;
  bool completed;

  factory TaskModel.fromSnapshot(DataSnapshot snapshot) => TaskModel(
        key: snapshot?.key ?? null,
        subject: snapshot.value["subject"] == null
            ? null
            : snapshot.value["subject"],
        task: snapshot.value["task"] == null ? null : snapshot.value["task"],
        completed: snapshot.value["completed"] == null
            ? null
            : snapshot.value["completed"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "subject": subject == null ? null : subject,
        "task": task == null ? null : task,
        "completed": completed == null ? null : completed,
      };
}
