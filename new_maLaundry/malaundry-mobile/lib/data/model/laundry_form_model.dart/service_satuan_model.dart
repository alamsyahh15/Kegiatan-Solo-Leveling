// To parse this JSON data, do
//
//     final serviceSatuanModel = serviceSatuanModelFromJson(jsonString);

import 'dart:convert';

ServiceSatuanModel serviceSatuanModelFromJson(String str) =>
    ServiceSatuanModel.fromJson(json.decode(str));

String serviceSatuanModelToJson(ServiceSatuanModel data) =>
    json.encode(data.toJson());

class ServiceSatuanModel {
  ServiceSatuanModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
    this.namaCabang,
  });

  List<DataSatuan> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;
  List<dynamic> namaCabang;

  factory ServiceSatuanModel.fromJson(Map<String, dynamic> json) =>
      ServiceSatuanModel(
        data: json["data"] == null
            ? null
            : List<DataSatuan>.from(
                json["data"].map((x) => DataSatuan.fromJson(x))),
        draw: json["draw"],
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
        limit: json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        namaCabang: json["nama_cabang"] == null
            ? null
            : List<dynamic>.from(json["nama_cabang"].map((x) => x)),
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
        "nama_cabang": namaCabang == null
            ? null
            : List<dynamic>.from(namaCabang.map((x) => x)),
      };
}

class DataSatuan {
  DataSatuan({
    this.idServiceSatuan,
    this.idCabang,
    this.namaService,
    this.jumlah,
    this.durasi,
    this.satuanWaktu,
    this.harga,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.arrIdCabang,
    this.arrNamaCabang,
  });

  int idServiceSatuan;
  String idCabang;
  String namaService;
  String jumlah;
  String durasi;
  String satuanWaktu;
  String harga;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> arrIdCabang;
  List<dynamic> arrNamaCabang;

  factory DataSatuan.fromJson(Map<String, dynamic> json) => DataSatuan(
        idServiceSatuan: json["id_service_satuan"] == null
            ? null
            : json["id_service_satuan"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        namaService: json["nama_service"] == null ? null : json["nama_service"],
        jumlah: json['jumlah'] == null ? null : json["jumlah"],
        durasi: json["durasi"] == null ? null : json["durasi"],
        satuanWaktu: json["satuan_waktu"] == null ? null : json["satuan_waktu"],
        harga: json["harga"] == null ? null : json["harga"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        arrIdCabang: json["arr_id_cabang"] == null
            ? null
            : List<dynamic>.from(json["arr_id_cabang"].map((x) => x)),
        arrNamaCabang: json["arr_nama_cabang"] == null
            ? null
            : List<dynamic>.from(json["arr_nama_cabang"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_service_satuan": idServiceSatuan == null ? null : idServiceSatuan,
        "id_cabang": idCabang == null ? null : idCabang,
        "nama_service": namaService == null ? null : namaService,
        "jumlah": jumlah == null ? null : jumlah,
        "durasi": durasi == null ? null : durasi,
        "satuan_waktu": satuanWaktu == null ? null : satuanWaktu,
        "harga": harga == null ? null : harga,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "arr_id_cabang": arrIdCabang == null
            ? null
            : List<dynamic>.from(arrIdCabang.map((x) => x)),
        "arr_nama_cabang": arrNamaCabang == null
            ? null
            : List<dynamic>.from(arrNamaCabang.map((x) => x)),
      };
}
