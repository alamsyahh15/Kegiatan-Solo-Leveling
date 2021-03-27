// To parse this JSON data, do
//
//     final requestJemputModel = requestJemputModelFromJson(jsonString);

import 'dart:convert';

RequestJemputModel requestJemputModelFromJson(String str) =>
    RequestJemputModel.fromJson(json.decode(str));

String requestJemputModelToJson(RequestJemputModel data) =>
    json.encode(data.toJson());

class RequestJemputModel {
  RequestJemputModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataJemput> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory RequestJemputModel.fromJson(Map<String, dynamic> json) =>
      RequestJemputModel(
        data: json["data"] == null
            ? null
            : List<DataJemput>.from(
                json["data"].map((x) => DataJemput.fromJson(x))),
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

class DataJemput {
  DataJemput({
    this.idJemput,
    this.idKonsumen,
    this.idKurir,
    this.idCabang,
    this.berat,
    this.status,
    this.statusPersetujuanKurir,
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.namaCabang,
    this.namaKonsumen,
    this.namaKurir,
    this.createdDate,
    this.konsumen,
    this.kurir,
    this.cabang,
  });

  int idJemput;
  int idKonsumen;
  int idKurir;
  String idCabang;
  int berat;
  String status;
  String statusPersetujuanKurir;
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;
  String namaCabang;
  String namaKonsumen;
  String namaKurir;
  String createdDate;
  Konsumen konsumen;
  Kurir kurir;
  Cabang cabang;

  factory DataJemput.fromJson(Map<String, dynamic> json) => DataJemput(
        idJemput: json["id_jemput"] == null ? null : json["id_jemput"],
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        idKurir: json["id_kurir"] == null ? null : json["id_kurir"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        berat: json["berat"] == null ? null : json["berat"],
        status: json["status"] == null ? null : json["status"],
        statusPersetujuanKurir: json["status_persetujuan_kurir"] == null
            ? null
            : json["status_persetujuan_kurir"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
        namaKonsumen:
            json["nama_konsumen"] == null ? null : json["nama_konsumen"],
        namaKurir: json["nama_kurir"] == null ? null : json["nama_kurir"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        konsumen: json["konsumen"] == null
            ? null
            : Konsumen.fromJson(json["konsumen"]),
        kurir: json["kurir"] == null ? null : Kurir.fromJson(json["kurir"]),
        cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
      );

  Map<String, dynamic> toJson() => {
        "id_jemput": idJemput == null ? null : idJemput,
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "id_kurir": idKurir == null ? null : idKurir,
        "id_cabang": idCabang == null ? null : idCabang,
        "berat": berat == null ? null : berat,
        "status": status == null ? null : status,
        "status_persetujuan_kurir":
            statusPersetujuanKurir == null ? null : statusPersetujuanKurir,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "nama_cabang": namaCabang == null ? null : namaCabang,
        "nama_konsumen": namaKonsumen == null ? null : namaKonsumen,
        "nama_kurir": namaKurir == null ? null : namaKurir,
        "created_date": createdDate == null ? null : createdDate,
        "konsumen": konsumen == null ? null : konsumen.toJson(),
        "kurir": kurir == null ? null : kurir.toJson(),
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

class Konsumen {
  Konsumen({
    this.idKonsumen,
    this.idUser,
    this.kode,
    this.title,
    this.kuotaSetrika,
    this.kuotaCuci,
    this.foto,
    this.createdAt,
    this.updatedAt,
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
  Kurir user;

  factory Konsumen.fromJson(Map<String, dynamic> json) => Konsumen(
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
        user: json["user"] == null ? null : Kurir.fromJson(json["user"]),
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
        "user": user == null ? null : user.toJson(),
      };
}

class Kurir {
  Kurir({
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
  int idCabang;
  String alamat;
  String isActive;
  dynamic firebaseToken;
  dynamic firebaseTokenWeb;
  dynamic accessToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory Kurir.fromJson(Map<String, dynamic> json) => Kurir(
        id: json["id"] == null ? null : json["id"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        pin: json["pin"] == null ? null : json["pin"],
        pin2: json["pin_2"],
        telp: json["telp"] == null ? null : json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
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
        "id_cabang": idCabang == null ? null : idCabang,
        "alamat": alamat == null ? null : alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken,
        "firebase_token_web": firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
