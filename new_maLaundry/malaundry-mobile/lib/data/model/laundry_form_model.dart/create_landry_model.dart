// To parse this JSON data, do
//
//     final createLaundryModel = createLaundryModelFromJson(jsonString);

import 'dart:convert';

CreateLaundryModel createLaundryModelFromJson(String str) =>
    CreateLaundryModel.fromJson(json.decode(str));

String createLaundryModelToJson(CreateLaundryModel data) =>
    json.encode(data.toJson());

class CreateLaundryModel {
  CreateLaundryModel({
    this.status,
    this.message,
    this.newtoken,
    this.data,
    this.redirectTo,
  });

  bool status;
  String message;
  dynamic newtoken;
  Data data;
  String redirectTo;

  factory CreateLaundryModel.fromJson(Map<String, dynamic> json) =>
      CreateLaundryModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        newtoken: json["newtoken"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        redirectTo: json["redirect_to"] == null ? null : json["redirect_to"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "newtoken": newtoken,
        "data": data == null ? null : data.toJson(),
        "redirect_to": redirectTo == null ? null : redirectTo,
      };
}

class Data {
  Data({
    this.idCabang,
    this.idKonsumen,
    this.kodeTransaksi,
    this.pakaiKuota,
    this.parfum,
    this.catatan,
    this.luntur,
    this.tasKantong,
    this.totalTagihan,
    this.statusTagihan,
    this.metodePembayaran,
    this.jumlahBayar,
    this.sisaTagihan,
    this.diskon,
    this.kembalian,
    this.kuotaCuciUsed,
    this.kuotaSetrikaUsed,
    this.statusLaundry,
    this.statusPengambilan,
    this.photo,
    this.createdBy,
    this.updatedAt,
    this.createdAt,
    this.idTransaksi,
  });

  int idCabang;
  int idKonsumen;
  String kodeTransaksi;
  String pakaiKuota;
  String parfum;
  String catatan;
  String luntur;
  String tasKantong;
  String totalTagihan;
  String statusTagihan;
  String metodePembayaran;
  String jumlahBayar;
  String sisaTagihan;
  String diskon;
  String kembalian;
  String kuotaCuciUsed;
  String kuotaSetrikaUsed;
  String statusLaundry;
  String statusPengambilan;
  dynamic photo;
  String createdBy;
  DateTime updatedAt;
  DateTime createdAt;
  int idTransaksi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        kodeTransaksi:
            json["kode_transaksi"] == null ? null : json["kode_transaksi"],
        pakaiKuota: json["pakai_kuota"] == null ? null : json["pakai_kuota"],
        parfum: json["parfum"] == null ? null : json["parfum"],
        catatan: json["catatan"] == null ? null : json["catatan"],
        luntur: json["luntur"] == null ? null : json["luntur"],
        tasKantong: json["tas_kantong"] == null ? null : json["tas_kantong"],
        totalTagihan:
            json["total_tagihan"] == null ? null : json["total_tagihan"],
        statusTagihan:
            json["status_tagihan"] == null ? null : json["status_tagihan"],
        metodePembayaran: json["metode_pembayaran"] == null
            ? null
            : json["metode_pembayaran"],
        jumlahBayar: json["jumlah_bayar"] == null ? null : json["jumlah_bayar"],
        sisaTagihan: json["sisa_tagihan"] == null ? null : json["sisa_tagihan"],
        diskon: json["diskon"] == null ? null : json["diskon"],
        kembalian: json["kembalian"] == null ? null : json["kembalian"],
        kuotaCuciUsed:
            json["kuota_cuci_used"] == null ? null : json["kuota_cuci_used"],
        kuotaSetrikaUsed: json["kuota_setrika_used"] == null
            ? null
            : json["kuota_setrika_used"],
        statusLaundry:
            json["status_laundry"] == null ? null : json["status_laundry"],
        statusPengambilan: json["status_pengambilan"] == null
            ? null
            : json["status_pengambilan"],
        photo: json["photo"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idTransaksi: json["id_transaksi"] == null ? null : json["id_transaksi"],
      );

  Map<String, dynamic> toJson() => {
        "id_cabang": idCabang == null ? null : idCabang,
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "kode_transaksi": kodeTransaksi == null ? null : kodeTransaksi,
        "pakai_kuota": pakaiKuota == null ? null : pakaiKuota,
        "parfum": parfum == null ? null : parfum,
        "catatan": catatan == null ? null : catatan,
        "luntur": luntur == null ? null : luntur,
        "tas_kantong": tasKantong == null ? null : tasKantong,
        "total_tagihan": totalTagihan == null ? null : totalTagihan,
        "status_tagihan": statusTagihan == null ? null : statusTagihan,
        "metode_pembayaran": metodePembayaran == null ? null : metodePembayaran,
        "jumlah_bayar": jumlahBayar == null ? null : jumlahBayar,
        "sisa_tagihan": sisaTagihan == null ? null : sisaTagihan,
        "diskon": diskon == null ? null : diskon,
        "kembalian": kembalian == null ? null : kembalian,
        "kuota_cuci_used": kuotaCuciUsed == null ? null : kuotaCuciUsed,
        "kuota_setrika_used":
            kuotaSetrikaUsed == null ? null : kuotaSetrikaUsed,
        "status_laundry": statusLaundry == null ? null : statusLaundry,
        "status_pengambilan":
            statusPengambilan == null ? null : statusPengambilan,
        "photo": photo,
        "created_by": createdBy == null ? null : createdBy,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id_transaksi": idTransaksi == null ? null : idTransaksi,
      };
}
