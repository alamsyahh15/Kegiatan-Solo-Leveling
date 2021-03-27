// To parse this JSON data, do
//
//     final createPengeluaranModel = createPengeluaranModelFromJson(jsonString);

import 'dart:convert';

CreatePengeluaranModel createPengeluaranModelFromJson(String str) =>
    CreatePengeluaranModel.fromJson(json.decode(str));

String createPengeluaranModelToJson(CreatePengeluaranModel data) =>
    json.encode(data.toJson());

class CreatePengeluaranModel {
  CreatePengeluaranModel({
    this.status,
    this.message,
    this.newtoken,
    this.data,
  });

  bool status;
  String message;
  dynamic newtoken;
  DataCreatePengeluaran data;

  factory CreatePengeluaranModel.fromJson(Map<String, dynamic> json) =>
      CreatePengeluaranModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        newtoken: json["newtoken"],
        data: json["data"] == null
            ? null
            : DataCreatePengeluaran.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "newtoken": newtoken,
        "data": data == null ? null : data.toJson(),
      };
}

class DataCreatePengeluaran {
  DataCreatePengeluaran({
    this.createdBy,
    this.idCabang,
    this.idItem,
    this.jumlah,
    this.satuanUnit,
    this.totalHarga,
    this.catatan,
    this.kasSebelum,
    this.kasSesudah,
    this.updatedAt,
    this.createdAt,
    this.idPengeluaran,
  });

  String createdBy;
  int idCabang;
  String idItem;
  String jumlah;
  String satuanUnit;
  String totalHarga;
  String catatan;
  int kasSebelum;
  int kasSesudah;
  DateTime updatedAt;
  DateTime createdAt;
  int idPengeluaran;

  factory DataCreatePengeluaran.fromJson(Map<String, dynamic> json) =>
      DataCreatePengeluaran(
        createdBy: json["created_by"] == null ? null : json["created_by"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        idItem: json["id_item"] == null ? null : json["id_item"],
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        satuanUnit: json["satuan_unit"] == null ? null : json["satuan_unit"],
        totalHarga: json["total_harga"] == null ? null : json["total_harga"],
        catatan: json["catatan"] == null ? null : json["catatan"],
        kasSebelum: json["kas_sebelum"] == null ? null : json["kas_sebelum"],
        kasSesudah: json["kas_sesudah"] == null ? null : json["kas_sesudah"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idPengeluaran:
            json["id_pengeluaran"] == null ? null : json["id_pengeluaran"],
      );

  Map<String, dynamic> toJson() => {
        "created_by": createdBy == null ? null : createdBy,
        "id_cabang": idCabang == null ? null : idCabang,
        "id_item": idItem == null ? null : idItem,
        "jumlah": jumlah == null ? null : jumlah,
        "satuan_unit": satuanUnit == null ? null : satuanUnit,
        "total_harga": totalHarga == null ? null : totalHarga,
        "catatan": catatan == null ? null : catatan,
        "kas_sebelum": kasSebelum == null ? null : kasSebelum,
        "kas_sesudah": kasSesudah == null ? null : kasSesudah,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id_pengeluaran": idPengeluaran == null ? null : idPengeluaran,
      };
}
