// To parse this JSON data, do
//
//     final totalKasModel = totalKasModelFromJson(jsonString);

import 'dart:convert';

TotalKasModel totalKasModelFromJson(String str) =>
    TotalKasModel.fromJson(json.decode(str));

String totalKasModelToJson(TotalKasModel data) => json.encode(data.toJson());

class TotalKasModel {
  TotalKasModel({
    this.totalLaundry,
    this.totalPaket,
    this.totalPengeluaran,
    this.totalSaldo,
    this.totalTransfer,
  });

  String totalLaundry;
  String totalPaket;
  String totalPengeluaran;
  String totalSaldo;
  String totalTransfer;

  factory TotalKasModel.fromJson(Map<String, dynamic> json) => TotalKasModel(
        totalLaundry:
            json["total_laundry"] == null ? null : json["total_laundry"],
        totalPaket: json["total_paket"] == null ? null : json["total_paket"],
        totalPengeluaran: json["total_pengeluaran"] == null
            ? null
            : json["total_pengeluaran"],
        totalSaldo: json["total_saldo"] == null ? null : json["total_saldo"],
        totalTransfer:
            json["total_transfer"] == null ? null : json["total_transfer"],
      );

  Map<String, dynamic> toJson() => {
        "total_laundry": totalLaundry == null ? null : totalLaundry,
        "total_paket": totalPaket == null ? null : totalPaket,
        "total_pengeluaran": totalPengeluaran == null ? null : totalPengeluaran,
        "total_saldo": totalSaldo == null ? null : totalSaldo,
        "total_transfer": totalTransfer == null ? null : totalTransfer,
      };
}
