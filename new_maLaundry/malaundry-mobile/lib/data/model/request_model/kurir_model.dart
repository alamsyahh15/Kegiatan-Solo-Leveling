// To parse this JSON data, do
//
//     final kurirModel = kurirModelFromJson(jsonString);

import 'dart:convert';

KurirModel kurirModelFromJson(String str) =>
    KurirModel.fromJson(json.decode(str));

String kurirModelToJson(KurirModel data) => json.encode(data.toJson());

class KurirModel {
  KurirModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataKurir> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory KurirModel.fromJson(Map<String, dynamic> json) => KurirModel(
        data: json["data"] == null
            ? null
            : List<DataKurir>.from(
                json["data"].map((x) => DataKurir.fromJson(x))),
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

class DataKurir {
  DataKurir({
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
    this.namaCabang,
    this.createdDate,
    this.cabang,
  });

  int id;
  String namaDepan;
  String namaBelakang;
  String username;
  dynamic pin;
  dynamic pin2;
  String telp;
  String level;
  int idCabang;
  dynamic alamat;
  String isActive;
  dynamic firebaseToken;
  dynamic firebaseTokenWeb;
  dynamic accessToken;
  DateTime createdAt;
  DateTime updatedAt;
  String namaCabang;
  String createdDate;
  Cabang cabang;

  factory DataKurir.fromJson(Map<String, dynamic> json) => DataKurir(
        id: json["id"] == null ? null : json["id"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        pin: json["pin"],
        pin2: json["pin_2"],
        telp: json["telp"] == null ? null : json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
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
        namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "nama_depan": namaDepan == null ? null : namaDepan,
        "nama_belakang": namaBelakang == null ? null : namaBelakang,
        "username": username == null ? null : username,
        "pin": pin,
        "pin_2": pin2,
        "telp": telp == null ? null : telp,
        "level": level == null ? null : level,
        "id_cabang": idCabang == null ? null : idCabang,
        "alamat": alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken,
        "firebase_token_web": firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "nama_cabang": namaCabang == null ? null : namaCabang,
        "created_date": createdDate == null ? null : createdDate,
        "cabang": cabang == null ? null : cabang.toJson(),
      };
}

class Cabang {
  Cabang({
    this.idCabang,
    this.penanggungJawab,
    this.kodeCabang,
    this.currentPoint,
    this.namaCabang,
    this.email,
    this.telepon,
    this.whatsapp,
    this.ig,
    this.latitude,
    this.longitude,
    this.alamat,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int idCabang;
  int penanggungJawab;
  String kodeCabang;
  String currentPoint;
  String namaCabang;
  String email;
  String telepon;
  String whatsapp;
  String ig;
  double latitude;
  double longitude;
  String alamat;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory Cabang.fromJson(Map<String, dynamic> json) => Cabang(
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        penanggungJawab:
            json["penanggung_jawab"] == null ? null : json["penanggung_jawab"],
        kodeCabang: json["kode_cabang"] == null ? null : json["kode_cabang"],
        currentPoint:
            json["current_point"] == null ? null : json["current_point"],
        namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
        email: json["email"] == null ? null : json["email"],
        telepon: json["telepon"] == null ? null : json["telepon"],
        whatsapp: json["whatsapp"] == null ? null : json["whatsapp"],
        ig: json["ig"] == null ? null : json["ig"],
        latitude: json["latitude"] == null
            ? null
            : double.parse(json["latitude"].toString()),
        longitude: json["longitude"] == null
            ? null
            : double.parse(json["longitude"].toString()),
        alamat: json["alamat"] == null ? null : json["alamat"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_cabang": idCabang == null ? null : idCabang,
        "penanggung_jawab": penanggungJawab == null ? null : penanggungJawab,
        "kode_cabang": kodeCabang == null ? null : kodeCabang,
        "current_point": currentPoint == null ? null : currentPoint,
        "nama_cabang": namaCabang == null ? null : namaCabang,
        "email": email == null ? null : email,
        "telepon": telepon == null ? null : telepon,
        "whatsapp": whatsapp == null ? null : whatsapp,
        "ig": ig == null ? null : ig,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "alamat": alamat == null ? null : alamat,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
