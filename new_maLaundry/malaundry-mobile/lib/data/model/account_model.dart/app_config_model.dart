// To parse this JSON data, do
//
//     final appConfigModel = appConfigModelFromJson(jsonString);

import 'dart:convert';

AppConfigModel appConfigModelFromJson(String str) =>
    AppConfigModel.fromJson(json.decode(str));

String appConfigModelToJson(AppConfigModel data) => json.encode(data.toJson());

class AppConfigModel {
  AppConfigModel({
    this.id,
    this.url,
    this.title,
    this.logo,
    this.logoLong,
    this.whiteLogo,
    this.whiteLogoLong,
    this.printLogo,
    this.email,
    this.telp,
    this.whatsapp,
    this.instagram,
    this.radiusMaksimal,
    this.beratMinimal,
    this.sejarah,
    this.deskripsi,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String url;
  String title;
  String logo;
  String logoLong;
  String whiteLogo;
  String whiteLogoLong;
  String printLogo;
  String email;
  String telp;
  String whatsapp;
  String instagram;
  String radiusMaksimal;
  String beratMinimal;
  String sejarah;
  String deskripsi;
  DateTime createdAt;
  DateTime updatedAt;

  factory AppConfigModel.fromJson(Map<String, dynamic> json) => AppConfigModel(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
        logo: json["logo"] == null ? null : json["logo"],
        logoLong: json["logo_long"] == null ? null : json["logo_long"],
        whiteLogo: json["white_logo"] == null ? null : json["white_logo"],
        whiteLogoLong:
            json["white_logo_long"] == null ? null : json["white_logo_long"],
        printLogo: json["print_logo"] == null ? null : json["print_logo"],
        email: json["email"] == null ? null : json["email"],
        telp: json["telp"] == null ? null : json["telp"],
        whatsapp: json["whatsapp"] == null ? null : json["whatsapp"],
        instagram: json["instagram"] == null ? null : json["instagram"],
        radiusMaksimal:
            json["radius_maksimal"] == null ? null : json["radius_maksimal"],
        beratMinimal:
            json["berat_minimal"] == null ? null : json["berat_minimal"],
        sejarah: json["sejarah"] == null ? null : json["sejarah"],
        deskripsi: json["deskripsi"] == null ? null : json["deskripsi"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "title": title == null ? null : title,
        "logo": logo == null ? null : logo,
        "logo_long": logoLong == null ? null : logoLong,
        "white_logo": whiteLogo == null ? null : whiteLogo,
        "white_logo_long": whiteLogoLong == null ? null : whiteLogoLong,
        "print_logo": printLogo == null ? null : printLogo,
        "email": email == null ? null : email,
        "telp": telp == null ? null : telp,
        "whatsapp": whatsapp == null ? null : whatsapp,
        "instagram": instagram == null ? null : instagram,
        "radius_maksimal": radiusMaksimal == null ? null : radiusMaksimal,
        "berat_minimal": beratMinimal == null ? null : beratMinimal,
        "sejarah": sejarah == null ? null : sejarah,
        "deskripsi": deskripsi == null ? null : deskripsi,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
