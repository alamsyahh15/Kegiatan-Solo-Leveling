// To parse this JSON data, do
//
//     final modelPegawai = modelPegawaiFromMap(jsonString);

import 'dart:convert';

List<ModelPegawai> modelPegawaiFromMap(String str) => List<ModelPegawai>.from(
    json.decode(str).map((x) => ModelPegawai.fromMap(x)));

String modelPegawaiToMap(List<ModelPegawai> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class ModelPegawai {
  ModelPegawai({
    this.id,
    this.nama,
    this.posisi,
    this.gaji,
  });

  String id;
  String nama;
  String posisi;
  String gaji;

  factory ModelPegawai.fromMap(Map<String, dynamic> json) => ModelPegawai(
        id: json["id"] == null ? null : json["id"],
        nama: json["nama"] == null ? null : json["nama"],
        posisi: json["posisi"] == null ? null : json["posisi"],
        gaji: json["gaji"] == null ? null : json["gaji"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "namaPegawai": nama == null ? null : nama,
        "posisiPegawai": posisi == null ? null : posisi,
        "gajiPegawai": gaji == null ? null : gaji,
      };
}
