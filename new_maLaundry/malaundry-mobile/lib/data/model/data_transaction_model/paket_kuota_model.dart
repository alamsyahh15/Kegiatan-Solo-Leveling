// To parse this JSON data, do
//
//     final paketKuotaModel = paketKuotaModelFromJson(jsonString);

import 'dart:convert';

PaketKuotaModel paketKuotaModelFromJson(String str) =>
    PaketKuotaModel.fromJson(json.decode(str));

String paketKuotaModelToJson(PaketKuotaModel data) =>
    json.encode(data.toJson());

class PaketKuotaModel {
  PaketKuotaModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
    this.namaCabang,
  });

  List<DataKuota> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;
  List<String> namaCabang;

  factory PaketKuotaModel.fromJson(Map<String, dynamic> json) =>
      PaketKuotaModel(
        data: json["data"] == null
            ? null
            : List<DataKuota>.from(
                json["data"].map((x) => DataKuota.fromJson(x))),
        draw: json["draw"],
        recordsTotal:
            json["recordsTotal"] == null ? null : json["recordsTotal"],
        recordsFiltered:
            json["recordsFiltered"] == null ? null : json["recordsFiltered"],
        limit: json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        namaCabang: json["nama_cabang"] == null
            ? null
            : List<String>.from(json["nama_cabang"].map((x) => x)),
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

class DataKuota {
  DataKuota({
    this.idPaketKuota,
    this.idCabang,
    this.jenisPaket,
    this.berat,
    this.unit,
    this.harga,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.arrIdCabang,
    this.arrNamaCabang,
    this.createdDate,
  });

  int idPaketKuota;
  String idCabang;
  String jenisPaket;
  String berat;
  String unit;
  String harga;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> arrIdCabang;
  List<String> arrNamaCabang;
  String createdDate;

  factory DataKuota.fromJson(Map<String, dynamic> json) => DataKuota(
        idPaketKuota:
            json["id_paket_kuota"] == null ? null : json["id_paket_kuota"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        jenisPaket: json["jenis_paket"] == null ? null : json["jenis_paket"],
        berat: json["berat"] == null ? null : json["berat"],
        unit: json["unit"] == null ? null : json["unit"],
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
        createdDate: json["created_date"] == null ? null : json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "id_paket_kuota": idPaketKuota == null ? null : idPaketKuota,
        "id_cabang": idCabang == null ? null : idCabang,
        "jenis_paket": jenisPaket == null ? null : jenisPaket,
        "berat": berat == null ? null : berat,
        "unit": unit == null ? null : unit,
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
        "created_date": createdDate == null ? null : createdDate,
      };
}
