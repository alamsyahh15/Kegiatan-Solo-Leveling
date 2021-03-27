// To parse this JSON data, do
//
//     final userChatModel = userChatModelFromJson(jsonString);

import 'dart:convert';

UserChatModel userChatModelFromJson(String str) =>
    UserChatModel.fromJson(json.decode(str));

String userChatModelToJson(UserChatModel data) => json.encode(data.toJson());

class UserChatModel {
  UserChatModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<UserChat> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory UserChatModel.fromJson(Map<String, dynamic> json) => UserChatModel(
        data: json["data"] == null
            ? null
            : List<UserChat>.from(
                json["data"].map((x) => UserChat.fromJson(x))),
        draw: json["draw"],
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
        limit: json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
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
      };
}

class UserChat {
  UserChat({
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
    this.namaKonsumen,
    this.fotoKonsumen,
    this.lastMsg,
    this.lastMsgAt,
    this.type,
    this.isRead,
  });

  int id;
  String namaDepan;
  String namaBelakang;
  String username;
  String pin;
  String pin2;
  String telp;
  String level;
  int idCabang;
  String alamat;
  String isActive;
  String firebaseToken;
  String firebaseTokenWeb;
  dynamic accessToken;
  DateTime createdAt;
  DateTime updatedAt;
  String namaKonsumen;
  String fotoKonsumen;
  String lastMsg;
  String lastMsgAt;
  String type;
  String isRead;

  factory UserChat.fromJson(Map<String, dynamic> json) => UserChat(
        id: json["id"] == null ? null : json["id"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        pin: json["pin"] == null ? null : json["pin"],
        pin2: json["pin_2"] == null ? null : json["pin_2"],
        telp: json["telp"] == null ? null : json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        alamat: json["alamat"] == null ? null : json["alamat"],
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
        namaKonsumen:
            json["nama_konsumen"] == null ? null : json["nama_konsumen"],
        fotoKonsumen:
            json["foto_konsumen"] == null ? null : json["foto_konsumen"],
        lastMsg: json["last_msg"] == null ? null : json["last_msg"],
        lastMsgAt: json["last_msg_at"] == null ? null : json["last_msg_at"],
        type: json["type"] == null ? null : json["type"],
        isRead: json["is_read"] == null ? null : json["is_read"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
        "username": username == null ? null : username,
        "pin": pin == null ? null : pin,
        "pin_2": pin2 == null ? null : pin2,
        "telp": telp == null ? null : telp,
        "level": level == null ? null : level,
        "id_cabang": idCabang == null ? null : idCabang,
        "alamat": alamat == null ? null : alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken == null ? null : firebaseToken,
        "firebase_token_web":
            firebaseTokenWeb == null ? null : firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "nama_konsumen": namaKonsumen == null ? null : namaKonsumen,
        "foto_konsumen": fotoKonsumen == null ? null : fotoKonsumen,
        "last_msg": lastMsg == null ? null : lastMsg,
        "last_msg_at": lastMsgAt == null ? null : lastMsgAt,
        "type": type == null ? null : type,
        "is_read": isRead == null ? null : isRead,
      };
}
