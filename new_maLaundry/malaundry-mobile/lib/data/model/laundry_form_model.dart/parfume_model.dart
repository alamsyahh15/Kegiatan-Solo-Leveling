// To parse this JSON data, do
//
//     final parfumeModel = parfumeModelFromJson(jsonString);

import 'dart:convert';

ParfumeModel parfumeModelFromJson(String str) =>
    ParfumeModel.fromJson(json.decode(str));

String parfumeModelToJson(ParfumeModel data) => json.encode(data.toJson());

class ParfumeModel {
  ParfumeModel({
    this.data,
    this.draw,
    this.recordsTotal,
    this.recordsFiltered,
    this.limit,
    this.offset,
  });

  List<DataParfume> data;
  dynamic draw;
  int recordsTotal;
  int recordsFiltered;
  dynamic limit;
  int offset;

  factory ParfumeModel.fromJson(Map<String, dynamic> json) => ParfumeModel(
        data: json["data"] == null
            ? null
            : List<DataParfume>.from(
                json["data"].map((x) => DataParfume.fromJson(x))),
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

class DataParfume {
  DataParfume({
    this.idParfum,
    this.labelParfum,
    this.deskripsi,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.createdDate,
  });

  int idParfum;
  String labelParfum;
  String deskripsi;
  String isActive;
  DateTime createdAt;
  String updatedAt;
  String createdDate;

  factory DataParfume.fromJson(Map<String, dynamic> json) => DataParfume(
        idParfum: json["id_parfum"] == null ? null : json["id_parfum"],
        labelParfum: json["label_parfum"] == null ? null : json["label_parfum"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
        isActive: json["is_active"] == null ? null : json["is_active"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        createdDate: json["created_date"] == null ? null : json["created_date"],
      );

  Map<String, dynamic> toJson() => {
        "id_parfum": idParfum == null ? null : idParfum,
        "label_parfum": labelParfum == null ? null : labelParfum,
        "deskripsi": deskripsi == null ? null : deskripsi,
        "is_active": isActive == null ? null : isActive,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt,
        "created_date": createdDate == null ? null : createdDate,
      };
}
