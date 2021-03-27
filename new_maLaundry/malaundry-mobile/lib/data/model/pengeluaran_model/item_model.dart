// To parse this JSON data, do
//
//     final itemModel = itemModelFromJson(jsonString);

import 'dart:convert';

ItemModel itemModelFromJson(String str) => ItemModel.fromJson(json.decode(str));

String itemModelToJson(ItemModel data) => json.encode(data.toJson());

class ItemModel {
  ItemModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
    this.namaCabang,
  });

  List<DataItem> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;
  List<dynamic> namaCabang;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        data: json["data"] == null
            ? null
            : List<DataItem>.from(
                json["data"].map((x) => DataItem.fromJson(x))),
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

class DataItem {
  DataItem({
    this.idItem,
    this.idCabang,
    this.item,
    this.kategori,
    this.deskripsi,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.arrIdCabang,
    this.arrNamaCabang,
    this.createdDate,
  });

  int idItem;
  String idCabang;
  String item;
  String kategori;
  String deskripsi;
  String isActive;
  DateTime createdAt;
  DateTime updatedAt;
  List<String> arrIdCabang;
  List<String> arrNamaCabang;
  String createdDate;

  factory DataItem.fromJson(Map<String, dynamic> json) => DataItem(
        idItem: json["id_item"] == null ? null : json["id_item"],
        idCabang: json["id_cabang"] == null ? null : json["id_cabang"],
        item: json["item"] == null ? null : json["item"],
        kategori: json["kategori"] == null ? null : json["kategori"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
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
        "id_item": idItem == null ? null : idItem,
        "id_cabang": idCabang == null ? null : idCabang,
        "item": item == null ? null : item,
        "kategori": kategori == null ? null : kategori,
        "deskripsi": deskripsi == null ? null : deskripsi,
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
