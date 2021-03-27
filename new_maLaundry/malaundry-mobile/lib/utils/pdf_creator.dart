import 'dart:io';
import 'dart:io' as Io;
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/local/app_config.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

abstract class PdfCreator {
  Future<String> createPdf(DataOrder data) async {
    var dir = Directory('/storage/emulated/0');
    if (dir.existsSync()) {
      await Io.Directory('${dir.path}/MaLaundry/Sent').create(recursive: true);
    }
    final pdf = pw.Document();
    final image = await rootBundle.load('assets/logo_print.jpg');

    pdf.addPage(
      pw.Page(
          pageFormat: PdfPageFormat.roll80,
          build: (pw.Context context) {
            return pw.Container(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.center,
                    child: pw.Image(
                      pw.MemoryImage(
                        image.buffer.asUint8List(),
                      ),
                      height: 70,
                    ),
                  ),
                  pw.SizedBox(height: medium),
                  pw.Align(
                    alignment: pw.Alignment.center,
                    child: pw.BarcodeWidget(
                      data: "${data?.kodeTransaksi}",
                      barcode: pw.Barcode.code39(),
                      drawText: false,
                      height: 70,
                    ),
                  ),
                  pw.SizedBox(height: medium),
                  pw.Text(
                    "${data?.kodeTransaksi ?? "-"}",
                    style: pw.TextStyle(fontSize: 8),
                  ),
                  pw.Text(
                    "${data?.cabang?.namaCabang ?? "-"} / ${data?.tanggalJam ?? "-"}",
                    style: pw.TextStyle(fontSize: 8),
                  ),
                  pw.Text(
                    "CSO : ${accountData?.account?.username ?? "-"}",
                    style: pw.TextStyle(fontSize: 8),
                  ),
                  pw.SizedBox(height: normal),
                  pw.Divider(thickness: 1),
                  pw.Text(
                    "${data?.konsumenFullName ?? "-"}",
                    style: pw.TextStyle(fontSize: 8),
                  ),
                  pw.Divider(thickness: 1),
                  pw.Text(
                    "${data?.konsumenNoHp ?? "-"}",
                    style: pw.TextStyle(fontSize: 8),
                  ),
                  pw.SizedBox(height: medium),

                  /// Kiloan List
                  (data?.kiloan?.length ?? 0) != 0
                      ? pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Service Kiloan",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 9),
                            ),
                            pw.Divider(thickness: 1),
                          ],
                        )
                      : pw.Container(),
                  (data?.kiloan?.length ?? 0) != 0
                      ? pw.Container(
                          child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: data.kiloan.map((kiloan) {
                            return pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "${kiloan.namaService}",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.Divider(thickness: 1),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Jumlah   : ${kiloan.jumlah} Kg",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "Harga    : ${double.parse(kiloan.hargaService).round()}",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  pw.Divider(thickness: 1),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Durasi   : ${kiloan.durasi} Hari",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "Subtotal    : ${double.parse(kiloan.totalHargaItem).round()}",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  pw.Divider(thickness: 1),
                                ]);
                          }).toList(),
                        ))
                      : pw.Center(),

                  /// Satuan List
                  (data?.satuan?.length ?? 0) != 0
                      ? pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(
                              "Service Satuan",
                              style: pw.TextStyle(
                                  fontWeight: pw.FontWeight.bold, fontSize: 9),
                            ),
                            pw.Divider(thickness: 1),
                          ],
                        )
                      : pw.Container(),
                  (data?.satuan?.length ?? 0) != 0
                      ? pw.Container(
                          child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          children: data.satuan.map((satuan) {
                            return pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text(
                                    "${satuan.namaService}",
                                    style: pw.TextStyle(
                                        fontSize: 8,
                                        fontWeight: pw.FontWeight.bold),
                                  ),
                                  pw.Divider(thickness: 1),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Jumlah   : ${satuan.jumlah} Kg",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "Harga    : ${double.parse(satuan.hargaService).round()}",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  pw.Divider(thickness: 1),
                                  pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Text(
                                        "Durasi   : ${satuan.durasi} Hari",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                      pw.Text(
                                        "Subtotal    : ${double.parse(satuan.totalHargaItem).round()}",
                                        style: pw.TextStyle(fontSize: 8),
                                      ),
                                    ],
                                  ),
                                  pw.Divider(thickness: 1),
                                ]);
                          }).toList(),
                        ))
                      : pw.Center(),

                  /// Lain Lain
                  pw.Text("Lain Lain",
                      style: pw.TextStyle(
                          fontSize: 8, fontWeight: pw.FontWeight.bold)),
                  pw.SizedBox(height: normal),
                  otherItem("Parfum", data?.parfum),
                  otherItem("Pembayaran", data?.metodePembayaran),
                  otherItem("Status Pembayaran", data?.statusTagihan),
                  otherItem("Total Tagihan", formatMoney(data?.totalTagihan)),
                  otherItem("Jumlah Bayar", formatMoney(data?.jumlahBayar)),
                  otherItem("Sisa Tagihan", formatMoney(data?.sisaTagihan)),
                  otherItem("Diskon", formatMoney(data?.diskon)),

                  pw.SizedBox(height: medium),
                  pw.Text(
                    "* Kain luntur, berkerut karena sifat diluar tanggung jawab",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 7,
                    ),
                  ),
                  pw.Text(
                    "* Biaya penggantian maksimal 10x dari biaya kiloan",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 7,
                    ),
                  ),
                  pw.Text(
                    "* Klaim max 24jam seteleah laundry diambil",
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 7,
                    ),
                  ),

                  pw.SizedBox(height: medium),
                  otherItem("Luntur", data?.luntur),
                  otherItem("Tas Kantong", data?.tasKantong),
                  otherItem("Catatan", data?.catatan),
                  pw.SizedBox(height: normal),
                  otherItem("WA: ${appConfigData?.appConfig?.whatsapp ?? "-"}",
                      "IG: ${appConfigData?.appConfig?.instagram ?? "-"}"),
                ],
              ),
            );
          }),
    );
    pdf.save();
    // var existDir = Directory('${dir.path}/MaLaundry/Sent');
    final file = File("${dir.path}/MaLaundry/Sent/${data.kodeTransaksi}.pdf");
    await file.writeAsBytes(await pdf.save());
    return "${data.kodeTransaksi}.pdf";
  }

  otherItem(String title, String content) {
    return pw.Row(
      children: [
        pw.Expanded(
          child: pw.Text(
            title ?? "",
            style: pw.TextStyle(fontSize: 8),
          ),
        ),
        pw.Expanded(
          child: pw.Text(
            ": ${content ?? "-"}",
            style: pw.TextStyle(fontSize: 8),
          ),
        ),
      ],
    );
  }
}
