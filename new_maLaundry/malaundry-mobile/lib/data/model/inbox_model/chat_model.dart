// To parse this JSON data, do
//
//     final chatModel = chatModelFromJson(jsonString);

import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
    this.inboxTo,
  });

  List<DataChat> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;
  String inboxTo;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        data: json["data"] == null
            ? null
            : List<DataChat>.from(
                json["data"].map((x) => DataChat.fromJson(x))),
        draw: json["draw"],
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
        limit: json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        inboxTo: json["inbox_to"] == null ? null : json["inbox_to"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
        "draw": draw,
        "recordsTotal": recordsTotal == null ? null : recordsTotal,
        "recordsFiltered": recordsFiltered == null ? null : recordsFiltered,
        "limit": limit,
        "offset": offset == null ? null : offset,
        "inbox_to": inboxTo == null ? null : inboxTo,
      };
}

class DataChat {
  DataChat({
    this.id,
    this.idInbox,
    this.idSender,
    this.chat,
    this.createdAt,
    this.updatedAt,
    this.position,
    this.timePosition,
    this.senderName,
    this.senderPict,
    this.createdDate,
    this.sender,
  });

  int id;
  String idInbox;
  String idSender;
  String chat;
  DateTime createdAt;
  DateTime updatedAt;
  String position;
  String timePosition;
  String senderName;
  String senderPict;
  String createdDate;
  Sender sender;

  factory DataChat.fromJson(Map<String, dynamic> json) => DataChat(
        id: json["id"] == null ? null : json["id"],
        idInbox: json["id_inbox"] == null ? null : json["id_inbox"],
        idSender: json["id_sender"] == null ? null : json["id_sender"],
        chat: json["chat"] == null ? null : json["chat"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        position: json["position"] == null ? null : json["position"],
        timePosition:
            json["time_position"] == null ? null : json["time_position"],
        senderName: json["sender_name"] == null ? null : json["sender_name"],
        senderPict: json["sender_pict"] == null ? null : json["sender_pict"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_inbox": idInbox == null ? null : idInbox,
        "id_sender": idSender == null ? null : idSender,
        "chat": chat == null ? null : chat,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "position": position == null ? null : position,
        "time_position": timePosition == null ? null : timePosition,
        "sender_name": senderName == null ? null : senderName,
        "sender_pict": senderPict == null ? null : senderPict,
        "created_date": createdDate == null ? null : createdDate,
        "sender": sender == null ? null : sender.toJson(),
      };
}

class Sender {
  Sender({
    this.id,
    this.namaDepan,
    this.namaBelakang,
    this.username,
    this.pin,
    this.pin2,
    this.telp,
    this.level,
    this.idCabang,
    this.alamat,
    this.isActive,
    this.firebaseToken,
    this.firebaseTokenWeb,
    this.accessToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String namaDepan;
  String namaBelakang;
  String username;
  dynamic pin;
  String pin2;
  String telp;
  String level;
  int idCabang;
  dynamic alamat;
  String isActive;
  String firebaseToken;
  String firebaseTokenWeb;
  dynamic accessToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"] == null ? null : json["id"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        pin: json["pin"],
        pin2: json["pin_2"] == null ? null : json["pin_2"],
        telp: json["telp"] == null ? null : json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        alamat: json["alamat"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        firebaseToken:
            json["firebase_token"] == null ? null : json["firebase_token"],
        firebaseTokenWeb: json["firebase_token_web"] == null
            ? null
            : json["firebase_token_web"],
        accessToken: json["access_token"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
        "username": username == null ? null : username,
        "pin": pin,
        "pin_2": pin2 == null ? null : pin2,
        "telp": telp == null ? null : telp,
        "level": level == null ? null : level,
        "id_cabang": idCabang == null ? null : idCabang,
        "alamat": alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken == null ? null : firebaseToken,
        "firebase_token_web":
            firebaseTokenWeb == null ? null : firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
