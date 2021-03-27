// To parse this JSON data, do
//
//     final createConsumerModel = createConsumerModelFromJson(jsonString);

import 'dart:convert';

CreateConsumerModel createConsumerModelFromJson(String str) =>
    CreateConsumerModel.fromJson(json.decode(str));

String createConsumerModelToJson(CreateConsumerModel data) =>
    json.encode(data.toJson());

class CreateConsumerModel {
  CreateConsumerModel({
    this.status,
    this.message,
    this.newtoken,
    this.data,
  });

  bool status;
  String message;
  dynamic newtoken;
  DataCreateConsumer data;

  factory CreateConsumerModel.fromJson(Map<String, dynamic> json) =>
      CreateConsumerModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        newtoken: json["newtoken"],
        data: json["data"] == null
            ? null
            : DataCreateConsumer.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "newtoken": newtoken,
        "data": data == null ? null : data.toJson(),
      };
}

class DataCreateConsumer {
  DataCreateConsumer({
    this.idUser,
    this.kode,
    this.title,
    this.foto,
    this.updatedAt,
    this.createdAt,
    this.idKonsumen,
    this.user,
  });

  int idUser;
  String kode;
  String title;
  dynamic foto;
  DateTime updatedAt;
  DateTime createdAt;
  int idKonsumen;
  User user;

  factory DataCreateConsumer.fromJson(Map<String, dynamic> json) =>
      DataCreateConsumer(
        idUser: json["id_user"] == null ? null : json["id_user"],
        kode: json["kode"] == null ? null : json["kode"],
        title: json["title"] == null ? null : json["title"],
        foto: json["foto"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser == null ? null : idUser,
        "kode": kode == null ? null : kode,
        "title": title == null ? null : title,
        "foto": foto,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "user": user == null ? null : user.toJson(),
      };
}

class User {
  User({
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
  dynamic pin2;
  dynamic telp;
  String level;
  dynamic idCabang;
  dynamic alamat;
  String isActive;
  dynamic firebaseToken;
  dynamic firebaseTokenWeb;
  dynamic accessToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        pin: json["pin"] == null ? null : json["pin"],
        pin2: json["pin_2"],
        telp: json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"],
        alamat: json["alamat"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        firebaseToken: json["firebase_token"],
        firebaseTokenWeb: json["firebase_token_web"],
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
        "pin_2": pin2,
        "telp": telp,
        "level": level == null ? null : level,
        "id_cabang": idCabang,
        "alamat": alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken,
        "firebase_token_web": firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
