// To parse this JSON data, do
//
//     final inboxModel = inboxModelFromJson(jsonString);

import 'dart:convert';

InboxModel inboxModelFromJson(String str) =>
    InboxModel.fromJson(json.decode(str));

String inboxModelToJson(InboxModel data) => json.encode(data.toJson());

class InboxModel {
  InboxModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataInbox> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
        data: json["data"] == null
            ? null
            : List<DataInbox>.from(
                json["data"].map((x) => DataInbox.fromJson(x))),
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

class DataInbox {
  DataInbox({
    this.idInbox,
    this.idUser,
    this.idKonsumen,
    this.lastMsg,
    this.lastMsgAt,
    this.isReadUser,
    this.isReadKonsumen,
    this.createdAt,
    this.updatedAt,
    this.namaKonsumen,
    this.fotoKonsumen,
    this.type,
    this.isRead,
    this.konsumen,
  });

  int idInbox;
  String idUser;
  String idKonsumen;
  String lastMsg;
  String lastMsgAt;
  String isReadUser;
  String isReadKonsumen;
  DateTime createdAt;
  DateTime updatedAt;
  String namaKonsumen;
  String fotoKonsumen;
  String type;
  String isRead;
  Konsumen konsumen;

  factory DataInbox.fromJson(Map<String, dynamic> json) => DataInbox(
        idInbox: json["id_inbox"] == null ? null : json["id_inbox"],
        idUser: json["id_user"] == null ? null : "${json["id_user"]}",
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        lastMsg: json["last_msg"] == null ? null : json["last_msg"],
        lastMsgAt: json["last_msg_at"] == null ? null : json["last_msg_at"],
        isReadUser: json["is_read_user"] == null ? null : json["is_read_user"],
        isReadKonsumen:
            json["is_read_konsumen"] == null ? null : json["is_read_konsumen"],
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
        type: json["type"] == null ? null : json["type"],
        isRead: json["is_read"] == null ? null : json["is_read"],
        konsumen: json["konsumen"] == null
            ? null
            : Konsumen.fromJson(json["konsumen"]),
      );

  Map<String, dynamic> toJson() => {
        "id_inbox": idInbox == null ? null : idInbox,
        "id_user": idUser == null ? null : idUser,
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "last_msg": lastMsg == null ? null : lastMsg,
        "last_msg_at": lastMsgAt == null ? null : lastMsgAt,
        "is_read_user": isReadUser == null ? null : isReadUser,
        "is_read_konsumen": isReadKonsumen == null ? null : isReadKonsumen,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "nama_konsumen": namaKonsumen == null ? null : namaKonsumen,
        "foto_konsumen": fotoKonsumen == null ? null : fotoKonsumen,
        "type": type == null ? null : type,
        "is_read": isRead == null ? null : isRead,
        "konsumen": konsumen == null ? null : konsumen.toJson(),
      };
}

class Konsumen {
  Konsumen({
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

  factory Konsumen.fromJson(Map<String, dynamic> json) => Konsumen(
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
      };
}
