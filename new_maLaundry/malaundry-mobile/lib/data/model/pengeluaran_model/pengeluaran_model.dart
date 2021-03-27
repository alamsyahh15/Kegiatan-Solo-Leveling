// To parse this JSON data, do
//
//     final pengeluaranModel = pengeluaranModelFromJson(jsonString);

import 'dart:convert';

PengeluaranModel pengeluaranModelFromJson(String str) =>
    PengeluaranModel.fromJson(json.decode(str));

String pengeluaranModelToJson(PengeluaranModel data) =>
    json.encode(data.toJson());

class PengeluaranModel {
  PengeluaranModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataPengeluaran> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory PengeluaranModel.fromJson(Map<String, dynamic> json) =>
      PengeluaranModel(
        data: json["data"] == null
            ? null
            : List<DataPengeluaran>.from(
                json["data"].map((x) => DataPengeluaran.fromJson(x))),
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

class DataPengeluaran {
  DataPengeluaran({
    this.idPengeluaran,
    this.createdBy,
    this.idCabang,
    this.idItem,
    this.jumlah,
    this.satuanUnit,
    this.kasSebelum,
    this.totalHarga,
    this.kasSesudah,
    this.catatan,
    this.createdAt,
    this.updatedAt,
    this.createdByName,
    this.namaItem,
    this.kategori,
    this.namaCabang,
    this.createdDate,
    this.item,
    this.cabang,
  });

  int idPengeluaran;
  String createdBy;
  int idCabang;
  int idItem;
  String jumlah;
  String satuanUnit;
  String kasSebelum;
  String totalHarga;
  String kasSesudah;
  String catatan;
  DateTime createdAt;
  DateTime updatedAt;
  String createdByName;
  String namaItem;
  String kategori;
  String namaCabang;
  String createdDate;
  Item item;
  Cabang cabang;

  factory DataPengeluaran.fromJson(Map<String, dynamic> json) =>
      DataPengeluaran(
        idPengeluaran:
            json["id_pengeluaran"] == null ? null : json["id_pengeluaran"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        idItem: json["id_item"] == null ? null : json["id_item"],
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        satuanUnit: json["satuan_unit"] == null ? null : json["satuan_unit"],
        kasSebelum: json["kas_sebelum"] == null ? null : json["kas_sebelum"],
        totalHarga: json["total_harga"] == null ? null : json["total_harga"],
        kasSesudah: json["kas_sesudah"] == null ? null : json["kas_sesudah"],
        catatan: json["catatan"] == null ? null : json["catatan"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdByName:
            json["created_by_name"] == null ? null : json["created_by_name"],
        namaItem: json["nama_item"] == null ? null : json["nama_item"],
        kategori: json["kategori"] == null ? null : json["kategori"],
        namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
        cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
      );

  Map<String, dynamic> toJson() => {
        "id_pengeluaran": idPengeluaran == null ? null : idPengeluaran,
        "created_by": createdBy == null ? null : createdBy,
        "id_cabang": idCabang == null ? null : idCabang,
        "id_item": idItem == null ? null : idItem,
        "jumlah": jumlah == null ? null : jumlah,
        "satuan_unit": satuanUnit == null ? null : satuanUnit,
        "kas_sebelum": kasSebelum == null ? null : kasSebelum,
        "total_harga": totalHarga == null ? null : totalHarga,
        "kas_sesudah": kasSesudah == null ? null : kasSesudah,
        "catatan": catatan == null ? null : catatan,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_by_name": createdByName == null ? null : createdByName,
        "nama_item": namaItem == null ? null : namaItem,
        "kategori": kategori == null ? null : kategori,
        "nama_cabang": namaCabang == null ? null : namaCabang,
        "created_date": createdDate == null ? null : createdDate,
        "item": item == null ? null : item.toJson(),
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

class Item {
  Item({
    this.idItem,
    this.idCabang,
    this.item,
    this.kategori,
    this.deskripsi,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  int idItem;
  String idCabang;
  String item;
  String kategori;
  String deskripsi;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        idItem: json["id_item"] == null ? null : json["id_item"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        item: json["item"] == null ? null : json["item"],
        kategori: json["kategori"] == null ? null : json["kategori"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_item": idItem == null ? null : idItem,
        "id_cabang": idCabang == null ? null : idCabang,
        "item": item == null ? null : item,
        "kategori": kategori == null ? null : kategori,
        "deskripsi": deskripsi == null ? null : deskripsi,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
