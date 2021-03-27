// To parse this JSON data, do
//
//     final newInboxModel = newInboxModelFromJson(jsonString);

import 'dart:convert';

NewInboxModel newInboxModelFromJson(String str) =>
    NewInboxModel.fromJson(json.decode(str));

String newInboxModelToJson(NewInboxModel data) => json.encode(data.toJson());

class NewInboxModel {
  NewInboxModel({
    this.status,
    this.message,
    this.newtoken,
    this.data,
  });

  bool status;
  String message;
  dynamic newtoken;
  DataNewInbox data;

  factory NewInboxModel.fromJson(Map<String, dynamic> json) => NewInboxModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        newtoken: json["newtoken"],
        data: json["data"] == null ? null : DataNewInbox.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "newtoken": newtoken,
        "data": data == null ? null : data.toJson(),
      };
}

class DataNewInbox {
  DataNewInbox({
    this.idInbox,
    this.idUser,
    this.idKonsumen,
    this.lastMsg,
    this.lastMsgAt,
    this.isReadUser,
    this.isReadKonsumen,
    this.createdAt,
    this.updatedAt,
  });

  int idInbox;
  String idUser;
  String idKonsumen;
  String lastMsg;
  DateTime lastMsgAt;
  String isReadUser;
  String isReadKonsumen;
  DateTime createdAt;
  DateTime updatedAt;

  factory DataNewInbox.fromJson(Map<String, dynamic> json) => DataNewInbox(
        idInbox: json["id_inbox"] == null ? null : json["id_inbox"],
        idUser: json["id_user"] == null ? null : json["id_user"],
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        lastMsg: json["last_msg"] == null ? null : json["last_msg"],
        lastMsgAt: json["last_msg_at"] == null
            ? null
            : DateTime.parse(json["last_msg_at"]),
        isReadUser: json["is_read_user"] == null ? null : json["is_read_user"],
        isReadKonsumen:
            json["is_read_konsumen"] == null ? null : json["is_read_konsumen"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_inbox": idInbox == null ? null : idInbox,
        "id_user": idUser == null ? null : idUser,
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "last_msg": lastMsg == null ? null : lastMsg,
        "last_msg_at": lastMsgAt == null ? null : lastMsgAt.toIso8601String(),
        "is_read_user": isReadUser == null ? null : isReadUser,
        "is_read_konsumen": isReadKonsumen == null ? null : isReadKonsumen,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
