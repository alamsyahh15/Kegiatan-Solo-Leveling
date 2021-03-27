// To parse this JSON data, do
//
//     final detailPembayaranModel = detailPembayaranModelFromJson(jsonString);

import 'dart:convert';

DetailPembayaranModel detailPembayaranModelFromJson(String str) =>
    DetailPembayaranModel.fromJson(json.decode(str));

String detailPembayaranModelToJson(DetailPembayaranModel data) =>
    json.encode(data.toJson());

class DetailPembayaranModel {
  DetailPembayaranModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  PembayaranData data;

  factory DetailPembayaranModel.fromJson(Map<String, dynamic> json) =>
      DetailPembayaranModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        data:
            json["data"] == null ? null : PembayaranData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class PembayaranData {
  PembayaranData({
    this.laundry,
    this.pembayarans,
    this.pembayaran,
  });

  Laundry laundry;
  List<Pembayaran> pembayarans;
  Pembayaran pembayaran;

  factory PembayaranData.fromJson(Map<String, dynamic> json) => PembayaranData(
        laundry:
            json["laundry"] == null ? null : Laundry.fromJson(json["laundry"]),
        pembayarans:
            json["pembayarans"] == null && json["pembayarans"].length < 0
                ? null
                : List<Pembayaran>.from(
                    json["pembayarans"].map((x) => Pembayaran.fromJson(x))),
        pembayaran: json["pembayaran"] == null
            ? null
            : Pembayaran.fromJson(json["pembayaran"]),
      );

  Map<String, dynamic> toJson() => {
        "laundry": laundry == null ? null : laundry.toJson(),
        "pembayarans": pembayarans == null
            ? null
            : List<dynamic>.from(pembayarans.map((x) => x.toJson())),
        "pembayaran": pembayaran == null ? null : pembayaran.toJson(),
      };
}

class Laundry {
  Laundry({
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
  String jumlahBayar;
  String sisaTagihan;
  String diskon;
  int kembalian;
  String kuotaCuciUsed;
  String kuotaSetrikaUsed;
  String photo;
  String statusLaundry;
  String statusPengambilan;
  dynamic catatanComplaint;
  dynamic catatanCancel;
  dynamic catatanReceive;
  String createdBy;
  dynamic updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic tanggalPengambilan;
  String statusPersetujuan;

  factory Laundry.fromJson(Map<String, dynamic> json) => Laundry(
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
        catatanCancel: json["catatan_cancel"],
        catatanReceive: json["catatan_receive"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        tanggalPengambilan: json["tanggal_pengambilan"],
        statusPersetujuan: json["status_persetujuan"] == null
            ? null
            : json["status_persetujuan"],
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
        "catatan_cancel": catatanCancel,
        "catatan_receive": catatanReceive,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "tanggal_pengambilan": tanggalPengambilan,
        "status_persetujuan":
            statusPersetujuan == null ? null : statusPersetujuan,
      };
}

class Pembayaran {
  Pembayaran({
    this.idPembayaran,
    this.idTransaksi,
    this.jumlah,
    this.catatan,
    this.buktiBayar,
    this.statusPersetujuan,
    this.alasanDitolak,
    this.tanggalPersetujuan,
    this.createdAt,
    this.updatedAt,
  });

  int idPembayaran;
  int idTransaksi;
  String jumlah;
  String catatan;
  String buktiBayar;
  String statusPersetujuan;
  dynamic alasanDitolak;
  dynamic tanggalPersetujuan;
  DateTime createdAt;
  DateTime updatedAt;

  factory Pembayaran.fromJson(Map<String, dynamic> json) => Pembayaran(
        idPembayaran:
            json["id_pembayaran"] == null ? null : json["id_pembayaran"],
        idTransaksi: json["id_transaksi"] == null ? null : json["id_transaksi"],
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        catatan: json["catatan"] == null ? null : json["catatan"],
        buktiBayar: json["bukti_bayar"] == null ? null : json["bukti_bayar"],
        statusPersetujuan: json["status_persetujuan"] == null
            ? null
            : json["status_persetujuan"],
        alasanDitolak: json["alasan_ditolak"],
        tanggalPersetujuan: json["tanggal_persetujuan"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_pembayaran": idPembayaran == null ? null : idPembayaran,
        "id_transaksi": idTransaksi == null ? null : idTransaksi,
        "jumlah": jumlah == null ? null : jumlah,
        "catatan": catatan == null ? null : catatan,
        "bukti_bayar": buktiBayar == null ? null : buktiBayar,
        "status_persetujuan":
            statusPersetujuan == null ? null : statusPersetujuan,
        "alasan_ditolak": alasanDitolak,
        "tanggal_persetujuan": tanggalPersetujuan,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
