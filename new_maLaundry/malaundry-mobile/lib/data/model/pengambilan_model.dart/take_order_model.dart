// To parse this JSON data, do
//
//     final takeOrderModel = takeOrderModelFromJson(jsonString);

import 'dart:convert';

TakeOrderModel takeOrderModelFromJson(String str) =>
    TakeOrderModel.fromJson(json.decode(str));

String takeOrderModelToJson(TakeOrderModel data) => json.encode(data.toJson());

class TakeOrderModel {
  TakeOrderModel({
    this.status,
    this.message,
    this.newtoken,
    this.data,
  });

  bool status;
  String message;
  dynamic newtoken;
  Data data;

  factory TakeOrderModel.fromJson(Map<String, dynamic> json) => TakeOrderModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        newtoken: json["newtoken"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "newtoken": newtoken,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.idTransaksi,
    this.idCabang,
    this.idKonsumen,
    this.kodeTransaksi,
    this.pakaiKuota,
    this.parfum,
    this.catatan,
    this.luntur,
    this.tasKantong,
    this.bayarKuota,
    this.totalTagihan,
    this.statusTagihan,
    this.metodePembayaran,
    this.jumlahBayar,
    this.sisaTagihan,
    this.diskon,
    this.kembalian,
    this.kuotaCuciUsed,
    this.kuotaSetrikaUsed,
    this.photo,
    this.statusLaundry,
    this.statusPengambilan,
    this.catatanComplaint,
    this.catatanCancel,
    this.catatanReceive,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
    this.tanggalPengambilan,
    this.statusPersetujuan,
  });

  int idTransaksi;
  int idCabang;
  int idKonsumen;
  String kodeTransaksi;
  String pakaiKuota;
  String parfum;
  String catatan;
  String luntur;
  String tasKantong;
  int bayarKuota;
  String totalTagihan;
  String statusTagihan;
  String metodePembayaran;
  int jumlahBayar;
  int sisaTagihan;
  String diskon;
  int kembalian;
  String kuotaCuciUsed;
  String kuotaSetrikaUsed;
  String photo;
  String statusLaundry;
  String statusPengambilan;
  dynamic catatanComplaint;
  String catatanCancel;
  dynamic catatanReceive;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime tanggalPengambilan;
  dynamic statusPersetujuan;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        idTransaksi: json["id_transaksi"] == null ? null : json["id_transaksi"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        kodeTransaksi:
            json["kode_transaksi"] == null ? null : json["kode_transaksi"],
        pakaiKuota: json["pakai_kuota"] == null ? null : json["pakai_kuota"],
        parfum: json["parfum"] == null ? null : json["parfum"],
        catatan: json["catatan"] == null ? null : json["catatan"],
        luntur: json["luntur"] == null ? null : json["luntur"],
        tasKantong: json["tas_kantong"] == null ? null : json["tas_kantong"],
        bayarKuota: json["bayar_kuota"] == null ? null : json["bayar_kuota"],
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
        photo: json["photo"] == null ? null : json["photo"],
        statusLaundry:
            json["status_laundry"] == null ? null : json["status_laundry"],
        statusPengambilan: json["status_pengambilan"] == null
            ? null
            : json["status_pengambilan"],
        catatanComplaint: json["catatan_complaint"],
        catatanCancel:
            json["catatan_cancel"] == null ? null : json["catatan_cancel"],
        catatanReceive: json["catatan_receive"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        tanggalPengambilan: json["tanggal_pengambilan"] == null
            ? null
            : DateTime.parse(json["tanggal_pengambilan"]),
        statusPersetujuan: json["status_persetujuan"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi == null ? null : idTransaksi,
        "id_cabang": idCabang == null ? null : idCabang,
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "kode_transaksi": kodeTransaksi == null ? null : kodeTransaksi,
        "pakai_kuota": pakaiKuota == null ? null : pakaiKuota,
        "parfum": parfum == null ? null : parfum,
        "catatan": catatan == null ? null : catatan,
        "luntur": luntur == null ? null : luntur,
        "tas_kantong": tasKantong == null ? null : tasKantong,
        "bayar_kuota": bayarKuota == null ? null : bayarKuota,
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
        "photo": photo == null ? null : photo,
        "status_laundry": statusLaundry == null ? null : statusLaundry,
        "status_pengambilan":
            statusPengambilan == null ? null : statusPengambilan,
        "catatan_complaint": catatanComplaint,
        "catatan_cancel": catatanCancel == null ? null : catatanCancel,
        "catatan_receive": catatanReceive,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "tanggal_pengambilan": tanggalPengambilan == null
            ? null
            : tanggalPengambilan.toIso8601String(),
        "status_persetujuan": statusPersetujuan,
      };
}
