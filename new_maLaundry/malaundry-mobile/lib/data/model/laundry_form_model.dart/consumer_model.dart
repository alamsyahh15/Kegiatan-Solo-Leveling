// To parse this JSON data, do
//
//     final consumerModel = consumerModelFromJson(jsonString);

import 'dart:convert';

ConsumerModel consumerModelFromJson(String str) =>
    ConsumerModel.fromJson(json.decode(str));

String consumerModelToJson(ConsumerModel data) => json.encode(data.toJson());

class ConsumerModel {
  ConsumerModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataConsumer> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory ConsumerModel.fromJson(Map<String, dynamic> json) => ConsumerModel(
        data: json["data"] == null
            ? null
            : List<DataConsumer>.from(
                json["data"].map((x) => DataConsumer.fromJson(x))),
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

class DataConsumer {
  DataConsumer({
    this.idKonsumen,
    this.idUser,
    this.kode,
    this.title,
    this.kuotaSetrika,
    this.kuotaCuci,
    this.foto,
    this.createdAt,
    this.updatedAt,
    this.alamat,
    this.namaDepan,
    this.namaBelakang,
    this.username,
    this.telp,
    this.isActive,
    this.isKuota,
    this.fotoKonsumen,
    this.createdDate,
    this.user,
  });

  int idKonsumen;
  int idUser;
  String kode;
  String title;
  String kuotaSetrika;
  String kuotaCuci;
  String foto;
  DateTime createdAt;
  DateTime updatedAt;
  String alamat;
  String namaDepan;
  String namaBelakang;
  String username;
  String telp;
  String isActive;
  String isKuota;
  String fotoKonsumen;
  String createdDate;
  User user;

  @override
  String toString() {
    return ("$idKonsumen $idUser $namaDepan $namaBelakang");
  }

  factory DataConsumer.fromJson(Map<String, dynamic> json) => DataConsumer(
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        idUser: json["id_user"] == null ? null : json["id_user"],
        kode: json["kode"] == null ? null : json["kode"],
        title: json["title"] == null ? null : json["title"],
        kuotaSetrika:
            json["kuota_setrika"] == null ? null : json["kuota_setrika"],
        kuotaCuci: json["kuota_cuci"] == null ? null : json["kuota_cuci"],
        foto: json["foto"] == null ? null : json["foto"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        alamat: json["alamat"] == null ? null : json["alamat"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        telp: json["telp"] == null ? null : json["telp"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        isKuota: json["is_kuota"] == null ? null : json["is_kuota"],
        fotoKonsumen:
            json["foto_konsumen"] == null ? null : json["foto_konsumen"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "id_user": idUser == null ? null : idUser,
        "kode": kode == null ? null : kode,
        "title": title == null ? null : title,
        "kuota_setrika": kuotaSetrika == null ? null : kuotaSetrika,
        "kuota_cuci": kuotaCuci == null ? null : kuotaCuci,
        "foto": foto == null ? null : foto,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "alamat": alamat == null ? null : alamat,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
        "username": username == null ? null : username,
        "telp": telp == null ? null : telp,
        "is_active": isActive == null ? null : isActive,
        "is_kuota": isKuota == null ? null : isKuota,
        "foto_konsumen": fotoKonsumen == null ? null : fotoKonsumen,
        "created_date": createdDate == null ? null : createdDate,
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
  String telp;
  String level;
  dynamic idCabang;
  String alamat;
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
        telp: json["telp"] == null ? null : json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"],
        alamat: json["alamat"] == null ? null : json["alamat"],
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
        "telp": telp == null ? null : telp,
        "level": level == null ? null : level,
        "id_cabang": idCabang,
        "alamat": alamat == null ? null : alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken,
        "firebase_token_web": firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
