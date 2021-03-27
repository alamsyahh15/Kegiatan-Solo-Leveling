// To parse this JSON data, do
//
//     final serviceKiloanModel = serviceKiloanModelFromJson(jsonString);

import 'dart:convert';

ServiceKiloanModel serviceKiloanModelFromJson(String str) =>
    ServiceKiloanModel.fromJson(json.decode(str));

String serviceKiloanModelToJson(ServiceKiloanModel data) =>
    json.encode(data.toJson());

class ServiceKiloanModel {
  ServiceKiloanModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
    this.namaCabang,
  });

  List<DataKiloan> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;
  String namaCabang;

  factory ServiceKiloanModel.fromJson(Map<String, dynamic> json) =>
      ServiceKiloanModel(
        data: json["data"] == null
            ? null
            : List<DataKiloan>.from(
                json["data"].map((x) => DataKiloan.fromJson(x))),
        draw: json["draw"],
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
        limit: json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        namaCabang: json["nama_cabang"] == null ? null : json["nama_cabang"],
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
        "nama_cabang": namaCabang == null ? null : namaCabang,
      };
}

class DataKiloan {
  DataKiloan({
    this.idServiceKiloan,
    this.idCabang,
    this.namaService,
    this.tipeService,
    this.jenisService,
    this.berat,
    this.satuanUnit,
    this.durasi,
    this.satuanWaktu,
    this.harga,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.arrIdCabang,
    this.arrNamaCabang,
  });

  int idServiceKiloan;
  String idCabang;
  String namaService;
  String tipeService;
  String jenisService;
  String berat;
  String satuanUnit;
  String durasi;
  String satuanWaktu;
  String harga;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> arrIdCabang;
  List<String> arrNamaCabang;

  factory DataKiloan.fromJson(Map<String, dynamic> json) => DataKiloan(
        idServiceKiloan: json["id_service_kiloan"] == null
            ? null
            : json["id_service_kiloan"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        namaService: json["nama_service"] == null ? null : json["nama_service"],
        tipeService: json["tipe_service"] == null ? null : json["tipe_service"],
        jenisService:
            json["jenis_service"] == null ? null : json["jenis_service"],
        berat: json["berat"] == null ? null : json["berat"],
        satuanUnit: json["satuan_unit"] == null ? null : json["satuan_unit"],
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
            : List<String>.from(json["arr_id_cabang"].map((x) => x)),
        arrNamaCabang: json["arr_nama_cabang"] == null
            ? null
            : List<String>.from(json["arr_nama_cabang"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id_service_kiloan": idServiceKiloan == null ? null : idServiceKiloan,
        "id_cabang": idCabang == null ? null : idCabang,
        "nama_service": namaService == null ? null : namaService,
        "tipe_service": tipeService == null ? null : tipeService,
        "jenis_service": jenisService == null ? null : jenisService,
        "berat": berat == null ? null : berat,
        "satuan_unit": satuanUnit == null ? null : satuanUnit,
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
