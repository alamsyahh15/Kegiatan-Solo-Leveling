// To parse this JSON data, do
//
//     final pembayaranModel = pembayaranModelFromJson(jsonString);

import 'dart:convert';

PembayaranModel pembayaranModelFromJson(String str) =>
    PembayaranModel.fromJson(json.decode(str));

String pembayaranModelToJson(PembayaranModel data) =>
    json.encode(data.toJson());

class PembayaranModel {
  PembayaranModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataPembayaran> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory PembayaranModel.fromJson(Map<String, dynamic> json) =>
      PembayaranModel(
        data: json["data"] == null
            ? null
            : List<DataPembayaran>.from(
                json["data"].map((x) => DataPembayaran.fromJson(x))),
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

class DataPembayaran {
  DataPembayaran({
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
    this.namaCabang,
    this.konsumenFullName,
    this.konsumenNoHp,
    this.tanggal,
    this.tanggalJam,
    this.tanggalJamPengambilan,
    this.isKuota,
    this.longestDuration,
    this.satuanWaktu,
    this.estPengambilan,
    this.cabang,
    this.konsumen,
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
  String catatanCancel;
  dynamic catatanReceive;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime tanggalPengambilan;
  String statusPersetujuan;
  String namaCabang;
  String konsumenFullName;
  String konsumenNoHp;
  String tanggal;
  String tanggalJam;
  String tanggalJamPengambilan;
  String isKuota;
  int longestDuration;
  String satuanWaktu;
  String estPengambilan;
  Cabang cabang;
  Konsumen konsumen;

  factory DataPembayaran.fromJson(Map<String, dynamic> json) => DataPembayaran(
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
        statusPersetujuan: json["status_persetujuan"] == null
            ? null
            : json["status_persetujuan"],
        namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
        konsumenFullName: json["konsumen_full_name"] == null
            ? null
            : json["konsumen_full_name"],
        konsumenNoHp:
            json["konsumen_no_hp"] == null ? null : json["konsumen_no_hp"],
        tanggal: json["tanggal"] == null ? null : json["tanggal"],
        tanggalJam: json["tanggal_jam"] == null ? null : json["tanggal_jam"],
        tanggalJamPengambilan: json["tanggal_jam_pengambilan"] == null
            ? null
            : json["tanggal_jam_pengambilan"],
        isKuota: json["is_kuota"] == null ? null : json["is_kuota"],
        longestDuration:
            json["longest_duration"] == null ? null : json["longest_duration"],
        satuanWaktu: json["satuan_waktu"] == null ? null : json["satuan_waktu"],
        estPengambilan:
            json["est_pengambilan"] == null ? null : json["est_pengambilan"],
        cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
        konsumen: json["konsumen"] == null
            ? null
            : Konsumen.fromJson(json["konsumen"]),
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
        "status_persetujuan":
            statusPersetujuan == null ? null : statusPersetujuan,
        "nama_cabang": namaCabang == null ? null : namaCabang,
        "konsumen_full_name":
            konsumenFullName == null ? null : konsumenFullName,
        "konsumen_no_hp": konsumenNoHp == null ? null : konsumenNoHp,
        "tanggal": tanggal == null ? null : tanggal,
        "tanggal_jam": tanggalJam == null ? null : tanggalJam,
        "tanggal_jam_pengambilan":
            tanggalJamPengambilan == null ? null : tanggalJamPengambilan,
        "is_kuota": isKuota == null ? null : isKuota,
        "longest_duration": longestDuration == null ? null : longestDuration,
        "satuan_waktu": satuanWaktu == null ? null : satuanWaktu,
        "est_pengambilan": estPengambilan == null ? null : estPengambilan,
        "cabang": cabang == null ? null : cabang.toJson(),
        "konsumen": konsumen == null ? null : konsumen.toJson(),
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
  User user;

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
