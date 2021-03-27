// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
    this.isNew,
  });

  List<DataNotif> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;
  bool isNew;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        data: json["data"] == null
            ? null
            : List<DataNotif>.from(
                json["data"].map((x) => DataNotif.fromJson(x))),
        draw: json["draw"],
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
        limit: json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        isNew: json["is_new"] == null ? null : json["is_new"],
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
        "is_new": isNew == null ? null : isNew,
      };
}

class DataNotif {
  DataNotif({
    this.id,
    this.datas,
    this.title,
    this.body,
    this.type,
    this.sendTo,
    this.sendBy,
    this.isRead,
    this.createdAt,
    this.updatedAt,
    this.sendByName,
    this.sendAt,
    this.urlTo,
  });

  int id;
  Datas datas;
  String title;
  String body;
  String type;
  SendBy sendTo;
  SendBy sendBy;
  String isRead;
  DateTime createdAt;
  DateTime updatedAt;
  String sendByName;
  String sendAt;
  String urlTo;

  factory DataNotif.fromJson(Map<String, dynamic> json) => DataNotif(
        id: json["id"] == null ? null : json["id"],
        datas: json["datas"] == null ? null : Datas.fromJson(json["datas"]),
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
        type: json["type"] == null ? null : json["type"],
        sendTo:
            json["send_to"] == null ? null : SendBy.fromJson(json["send_to"]),
        sendBy:
            json["send_by"] == null ? null : SendBy.fromJson(json["send_by"]),
        isRead: json["is_read"] == null ? null : json["is_read"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sendByName: json["send_by_name"] == null ? null : json["send_by_name"],
        sendAt: json["send_at"] == null ? null : json["send_at"],
        urlTo: json["url_to"] == null ? null : json["url_to"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "datas": datas == null ? null : datas.toJson(),
        "title": title == null ? null : title,
        "body": body == null ? null : body,
        "type": type == null ? null : type,
        "send_to": sendTo == null ? null : sendTo.toJson(),
        "send_by": sendBy == null ? null : sendBy.toJson(),
        "is_read": isRead == null ? null : isRead,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "send_by_name": sendByName == null ? null : sendByName,
        "send_at": sendAt == null ? null : sendAt,
        "url_to": urlTo == null ? null : urlTo,
      };
}

class Datas {
  Datas({
    this.idTransaksi,
    this.idKonsumen,
    this.idKurir,
    this.latitude,
    this.longitude,
    this.status,
    this.statusPersetujuanKurir,
    this.updatedAt,
    this.createdAt,
    this.idAntar,
    this.konsumen,
    this.idJemput,
    this.idCabang,
    this.berat,
    this.kurir,
    this.cabang,
    this.laundry,
    this.jumlah,
    this.catatan,
    this.buktiBayar,
    this.statusPersetujuan,
    this.idPembayaran,
  });

  dynamic idTransaksi;
  dynamic idKonsumen;
  dynamic idKurir;
  dynamic latitude;
  dynamic longitude;
  String status;
  String statusPersetujuanKurir;
  DateTime updatedAt;
  DateTime createdAt;
  int idAntar;
  Konsumen konsumen;
  int idJemput;
  String idCabang;
  dynamic berat;
  SendBy kurir;
  Cabang cabang;
  Laundry laundry;
  String jumlah;
  String catatan;
  String buktiBayar;
  String statusPersetujuan;
  int idPembayaran;

  factory Datas.fromJson(Map<String, dynamic> json) => Datas(
        idTransaksi: json["id_transaksi"],
        idKonsumen: json["id_konsumen"],
        idKurir: json["id_kurir"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        status: json["status"] == null ? null : json["status"],
        statusPersetujuanKurir: json["status_persetujuan_kurir"] == null
            ? null
            : json["status_persetujuan_kurir"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        idAntar: json["id_antar"] == null ? null : json["id_antar"],
        konsumen: json["konsumen"] == null
            ? null
            : Konsumen.fromJson(json["konsumen"]),
        idJemput: json["id_jemput"] == null ? null : json["id_jemput"],
        idCabang: json["id_cabang"] == null ? null : "${json["id_cabang"]}",
        berat: json["berat"],
        kurir: json["kurir"] == null ? null : SendBy.fromJson(json["kurir"]),
        cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
        laundry:
            json["laundry"] == null ? null : Laundry.fromJson(json["laundry"]),
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        catatan: json["catatan"] == null ? null : json["catatan"],
        buktiBayar: json["bukti_bayar"] == null ? null : json["bukti_bayar"],
        statusPersetujuan: json["status_persetujuan"] == null
            ? null
            : json["status_persetujuan"],
        idPembayaran:
            json["id_pembayaran"] == null ? null : json["id_pembayaran"],
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi,
        "id_konsumen": idKonsumen,
        "id_kurir": idKurir,
        "latitude": latitude,
        "longitude": longitude,
        "status": status == null ? null : status,
        "status_persetujuan_kurir":
            statusPersetujuanKurir == null ? null : statusPersetujuanKurir,
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "id_antar": idAntar == null ? null : idAntar,
        "konsumen": konsumen == null ? null : konsumen.toJson(),
        "id_jemput": idJemput == null ? null : idJemput,
        "id_cabang": idCabang == null ? null : idCabang,
        "berat": berat,
        "kurir": kurir == null ? null : kurir.toJson(),
        "cabang": cabang == null ? null : cabang.toJson(),
        "laundry": laundry == null ? null : laundry.toJson(),
        "jumlah": jumlah == null ? null : jumlah,
        "catatan": catatan == null ? null : catatan,
        "bukti_bayar": buktiBayar == null ? null : buktiBayar,
        "status_persetujuan":
            statusPersetujuan == null ? null : statusPersetujuan,
        "id_pembayaran": idPembayaran == null ? null : idPembayaran,
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
  SendBy user;

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
        user: json["user"] == null ? null : SendBy.fromJson(json["user"]),
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

class SendBy {
  SendBy({
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
  String pin2;
  String telp;
  String level;
  int idCabang;
  String alamat;
  String isActive;
  dynamic firebaseToken;
  String firebaseTokenWeb;
  dynamic accessToken;
  DateTime createdAt;
  DateTime updatedAt;

  factory SendBy.fromJson(Map<String, dynamic> json) => SendBy(
        id: json["id"] == null ? null : json["id"],
        namaDepan: json["nama_depan"] == null ? null : json["nama_depan"],
        namaBelakang:
            json["nama_belakang"] == null ? null : json["nama_belakang"],
        username: json["username"] == null ? null : json["username"],
        pin: json["pin"] == null ? null : json["pin"],
        pin2: json["pin_2"] == null ? null : json["pin_2"],
        telp: json["telp"] == null ? null : json["telp"],
        level: json["level"] == null ? null : json["level"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        firebaseToken: json["firebase_token"],
        firebaseTokenWeb: json["firebase_token_web"] == null
            ? null
            : json["firebase_token_web"],
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
        "pin_2": pin2 == null ? null : pin2,
        "telp": telp == null ? null : telp,
        "level": level == null ? null : level,
        "id_cabang": idCabang == null ? null : idCabang,
        "alamat": alamat == null ? null : alamat,
        "is_active": isActive == null ? null : isActive,
        "firebase_token": firebaseToken,
        "firebase_token_web":
            firebaseTokenWeb == null ? null : firebaseTokenWeb,
        "access_token": accessToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
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
    this.cabang,
  });

  int idTransaksi;
  int idCabang;
  int idKonsumen;
  String kodeTransaksi;
  String pakaiKuota;
  String parfum;
  dynamic catatan;
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
  dynamic photo;
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
  dynamic statusPersetujuan;
  Cabang cabang;

  factory Laundry.fromJson(Map<String, dynamic> json) => Laundry(
        idTransaksi: json["id_transaksi"] == null ? null : json["id_transaksi"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        idKonsumen: json["id_konsumen"] == null ? null : json["id_konsumen"],
        kodeTransaksi:
            json["kode_transaksi"] == null ? null : json["kode_transaksi"],
        pakaiKuota: json["pakai_kuota"] == null ? null : json["pakai_kuota"],
        parfum: json["parfum"] == null ? null : json["parfum"],
        catatan: json["catatan"],
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
        photo: json["photo"],
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
        statusPersetujuan: json["status_persetujuan"],
        cabang: json["cabang"] == null ? null : Cabang.fromJson(json["cabang"]),
      );

  Map<String, dynamic> toJson() => {
        "id_transaksi": idTransaksi == null ? null : idTransaksi,
        "id_cabang": idCabang == null ? null : idCabang,
        "id_konsumen": idKonsumen == null ? null : idKonsumen,
        "kode_transaksi": kodeTransaksi == null ? null : kodeTransaksi,
        "pakai_kuota": pakaiKuota == null ? null : pakaiKuota,
        "parfum": parfum == null ? null : parfum,
        "catatan": catatan,
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
        "photo": photo,
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
        "status_persetujuan": statusPersetujuan,
        "cabang": cabang == null ? null : cabang.toJson(),
      };
}
