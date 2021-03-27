// To parse this JSON data, do
//
//     final createPaketModel = createPaketModelFromJson(jsonString);

import 'dart:convert';

CreatePaketModel createPaketModelFromJson(String str) =>
    CreatePaketModel.fromJson(json.decode(str));

String createPaketModelToJson(CreatePaketModel data) =>
    json.encode(data.toJson());

class CreatePaketModel {
  CreatePaketModel({
    this.status,
    this.message,
    this.newtoken,
    this.data,
  });

  bool status;
  String message;
  dynamic newtoken;
  DataPaket data;

  factory CreatePaketModel.fromJson(Map<String, dynamic> json) =>
      CreatePaketModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        newtoken: json["newtoken"],
        data: json["data"] == null ? null : DataPaket.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "newtoken": newtoken,
        "data": data == null ? null : data.toJson(),
      };
}

class DataPaket {
  DataPaket({
    this.idKonsumen,
    this.idPaketKuota,
    this.kodeTransaksi,
    this.createdBy,
    this.idCabang,
    this.jenisPaket,
    this.berat,
    this.unit,
    this.harga,
    this.metodePembayaran,
    this.totalBayar,
    this.updatedAt,
    this.createdAt,
    this.idTransaksiPaket,
  });

  String idKonsumen;
  String idPaketKuota;
  String kodeTransaksi;
  String createdBy;
  int idCabang;
  String jenisPaket;
  String berat;
  String unit;
  String harga;
  String metodePembayaran;
  String totalBayar;
  DateTime updatedAt;
  DateTime createdAt;
  int idTransaksiPaket;

  factory DataPaket.fromJson(Map<String, dynamic> json) => DataPaket(
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        idPaketKuota:
            json["id_paket_kuota"] == null ? null : json["id_paket_kuota"],
        kodeTransaksi:
            json["kode_transaksi"] == null ? null : json["kode_transaksi"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        jenisPaket: json["jenis_paket"] == null ? null : json["jenis_paket"],
        berat: json["berat"] == null ? null : json["berat"],
        unit: json["unit"] == null ? null : json["unit"],
        harga: json["harga"] == null ? null : json["harga"],
        metodePembayaran: json["metode_pembayaran"] == null
            ? null
            : json["metode_pembayaran"],
        totalBayar: json["total_bayar"] == null ? null : json["total_bayar"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idTransaksiPaket: json["id_transaksi_paket"] == null
            ? null
            : json["id_transaksi_paket"],
      );

  Map<String, dynamic> toJson() => {
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "id_paket_kuota": idPaketKuota == null ? null : idPaketKuota,
        "kode_transaksi": kodeTransaksi == null ? null : kodeTransaksi,
        "created_by": createdBy == null ? null : createdBy,
        "id_cabang": idCabang == null ? null : idCabang,
        "jenis_paket": jenisPaket == null ? null : jenisPaket,
        "berat": berat == null ? null : berat,
        "unit": unit == null ? null : unit,
        "harga": harga == null ? null : harga,
        "metode_pembayaran": metodePembayaran == null ? null : metodePembayaran,
        "total_bayar": totalBayar == null ? null : totalBayar,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id_transaksi_paket":
            idTransaksiPaket == null ? null : idTransaksiPaket,
      };
}
