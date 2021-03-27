import 'dart:developer';
import 'dart:typed_data';
import 'package:image/image.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/local/app_config.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';

Future printDocument(GlobalKey<ScaffoldState> key,
    {DataOrder dataOrder, @required Function(dynamic value) onClosing}) async {
  var result;
  PersistentBottomSheetController bottomSheetController =
      key.currentState.showBottomSheet(
    (context) => PrintDocumentForm(
      dataOder: dataOrder,
      afterPrint: (value) {
        result = value;
      },
    ),
    backgroundColor: Colors.black.withOpacity(0.35),
  );
  bottomSheetController.closed.then((value) {
    log("On Closed");
    if (onClosing != null) {
      onClosing(result);
    }
  });
}

class PrintDocumentForm extends StatefulWidget {
  final DataOrder dataOder;
  final DataConsumer dataConsumer;
  final Function(dynamic value) afterPrint;

  const PrintDocumentForm(
      {Key key, this.dataOder, this.dataConsumer, this.afterPrint})
      : super(key: key);
  @override
  _PrintDocumentFormState createState() => _PrintDocumentFormState();
}

class _PrintDocumentFormState extends State<PrintDocumentForm> {
  DataOrder get dataOrder => widget?.dataOder;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<PaperSize> paperSizeList = [PaperSize.mm80, PaperSize.mm58];
  PaperSize valuePaper;
  PrinterBluetoothManager printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> devices = [];
  bool _isSearch = false;
  bool get isSearch => _isSearch;
  set isSearch(bool val) {
    setState(() => _isSearch = val);
  }

  void startScanDevices() {
    setState(() => devices.clear());
    printerManager.startScan(Duration(seconds: 8));
  }

  void stopScanDevices() {
    printerManager.stopScan();
  }

  Future startPrint(PrinterBluetooth printer) async {
    if (valuePaper != null && dataOrder != null) {
      progressDialog(context);
      printerManager.selectPrinter(printer);
      // DEMO RECEIPT
      final PosPrintResult res =
          await printerManager.printTicket(await printDocStyle(valuePaper));
      // await printerManager.printTicket(await demoReceipt(valuePaper));
      Navigator.pop(context);
      Navigator.pop(context);
      log("Message ${res.msg}");
      return res.msg;
    } else {
      showLocalSnackbar("Silahkan Pilih Kertas", key);
      return null;
    }
  }

  Future<Ticket> demoReceipt(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);

    // Print image
    final ByteData data = await rootBundle.load('assets/frame58.jpg');
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    // ticket.image(image);

    ticket.text('GROCERYLY',
        styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
        ),
        linesAfter: 1);

    ticket.text('889  Watson Lane', styles: PosStyles(align: PosAlign.center));
    ticket.text('New Braunfels, TX', styles: PosStyles(align: PosAlign.center));
    ticket.text('Tel: 830-221-1234', styles: PosStyles(align: PosAlign.center));
    ticket.text('Web: www.example.com',
        styles: PosStyles(align: PosAlign.center), linesAfter: 1);

    ticket.hr();
    ticket.row([
      PosColumn(
          text: 'Qty', width: 3, styles: PosStyles(width: PosTextSize.size1)),
      PosColumn(
          text: 'Item', width: 3, styles: PosStyles(width: PosTextSize.size1)),
      PosColumn(
          text: 'Price',
          width: 3,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size1)),
      PosColumn(
          text: 'Total',
          width: 3,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size1)),
    ]);

    ticket.row([
      PosColumn(
          text: 'Change',
          width: 7,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size1)),
      PosColumn(
          text: '\$4.03',
          width: 5,
          styles: PosStyles(align: PosAlign.right, width: PosTextSize.size1)),
    ]);

    ticket.feed(2);
    ticket.text('Thank you!',
        styles: PosStyles(align: PosAlign.center, bold: true));

    ticket.feed(2);
    ticket.cut();
    return ticket;
  }

  Future<Ticket> printDocStyle(PaperSize paper) async {
    final Ticket ticket = Ticket(paper);
    String dataBar = "${dataOrder?.kodeTransaksi}";
    // Print image
    ByteData data;
    if (paper == PaperSize.mm58) {
      data = await rootBundle.load('assets/frame58.jpg');
    } else {
      data = await rootBundle.load('assets/frame80.jpg');
    }
    final Uint8List bytes = data.buffer.asUint8List();
    final Image image = decodeImage(bytes);
    ticket.image(image);
    List dataList = dataBar.split('');
    if (paper == PaperSize.mm58) {
      ticket.barcode(Barcode.code39(dataList),
          height: 80, textPos: BarcodeText.none);
    } else {
      ticket.barcode(Barcode.code39(dataList),
          height: 120, textPos: BarcodeText.none);
    }
    ticket.feed(1);
    ticket.text(
      '${dataOrder?.kodeTransaksi}'.toUpperCase(),
      styles: PosStyles(align: PosAlign.left),
    );
    ticket.text(
      "${dataOrder?.cabang?.namaCabang} / ${dataOrder?.tanggalJam}",
      styles: PosStyles(align: PosAlign.left),
    );
    ticket.text("CSO : ${accountData?.account?.username}",
        styles: PosStyles(align: PosAlign.left));

    ticket.hr();
    ticket.text(
      "${dataOrder?.konsumenFullName}",
      styles: PosStyles(align: PosAlign.left, bold: true),
    );
    ticket.hr();
    ticket.text("${dataOrder?.konsumenNoHp}",
        styles: PosStyles(align: PosAlign.left, bold: true), linesAfter: 1);

    /// Service Kiloan Data
    if ((dataOrder?.kiloan?.length ?? 0) > 0) {
      ticket.text("Service Kiloan",
          styles: PosStyles(align: PosAlign.left, bold: true));
      for (int i = 0; i < dataOrder.kiloan.length; i++) {
        Kiloan kiloan = dataOrder.kiloan[i];
        ticket.hr();
        ticket.row([
          PosColumn(text: 'Item', width: 2, styles: PosStyles(bold: true)),
          PosColumn(
              text: '${kiloan?.namaService}',
              width: 10,
              styles: PosStyles(bold: true)),
        ]);
        ticket.hr();
        ticket.row([
          PosColumn(
            text: 'Jumlah',
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${kiloan?.jumlah} Kg",
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Harga',
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${double.parse(kiloan?.hargaService).round()}",
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
        ]);
        ticket.hr();
        ticket.row([
          PosColumn(
            text: 'Durasi',
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${kiloan?.durasi} Hari",
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Subtotal',
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${double.parse(kiloan?.totalHargaItem).round()}",
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
        ]);
      }
    }

    /// List Satuan
    if ((dataOrder?.satuan?.length ?? 0) > 0) {
      ticket.feed(1);
      ticket.text("Service Satuan",
          styles: PosStyles(align: PosAlign.left, bold: true));
      for (int i = 0; i < dataOrder.satuan.length; i++) {
        Kiloan kiloan = dataOrder.satuan[i];
        ticket.hr();
        ticket.row([
          PosColumn(text: 'Item', width: 2, styles: PosStyles(bold: true)),
          PosColumn(
              text: '${kiloan?.namaService}',
              width: 10,
              styles: PosStyles(bold: true)),
        ]);
        ticket.hr();
        ticket.row([
          PosColumn(
            text: 'Jumlah',
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${kiloan?.jumlah} Pcs",
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Harga',
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${double.parse(kiloan?.hargaService).round()}",
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
        ]);
        ticket.hr();
        ticket.row([
          PosColumn(
            text: 'Durasi',
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${kiloan?.durasi} Hari",
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: 'Subtotal',
            width: 4,
            styles: PosStyles(align: PosAlign.left),
          ),
          PosColumn(
            text: ": ${double.parse(kiloan?.totalHargaItem).round()}",
            width: 2,
            styles: PosStyles(align: PosAlign.left),
          ),
        ]);
      }
    }
    ticket.hr();
    ticket.text("Lain Lain",
        styles: PosStyles(align: PosAlign.left, bold: true), linesAfter: 1);

    ticket.row([
      PosColumn(
        text: 'Parfum',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${dataOrder?.parfum}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Pembayaran',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${dataOrder?.metodePembayaran}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Status Pembayaran',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${dataOrder?.statusTagihan}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Total Tagihan',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${formatMoney(dataOrder?.totalTagihan)}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Jumlah Bayar',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${formatMoney(dataOrder?.jumlahBayar)}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Sisa Tagihan',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${formatMoney(dataOrder?.sisaTagihan)}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Diskon',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${formatMoney(dataOrder?.diskon)}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);

    ticket.feed(1);
    ticket.text(
      "* Kain luntur, berkerut karena sifat diluar tanggung jawab",
      styles: PosStyles(align: PosAlign.left),
    );
    ticket.text(
      "* Biaya penggantian maksimal 10x dari biaya kiloan",
      styles: PosStyles(align: PosAlign.left),
    );
    ticket.text(
      "* Klaim max 24jam setelah laundry diambil",
      styles: PosStyles(align: PosAlign.left),
    );
    ticket.feed(1);
    ticket.row([
      PosColumn(
        text: 'Luntur',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${dataOrder?.luntur}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Tas Kantong',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: ": ${dataOrder?.tasKantong}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);
    ticket.row([
      PosColumn(
        text: 'Catatan',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text:
            ": ${dataOrder?.catatan == "null" ? "-" : dataOrder?.catatan ?? "-"}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);

    ticket.feed(1);

    ticket.row([
      PosColumn(
        text: 'WA: ${appConfigData?.appConfig?.whatsapp ?? "-"}',
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: "IG: ${appConfigData?.appConfig?.instagram ?? "-"}",
        width: 6,
        styles: PosStyles(align: PosAlign.left),
      ),
    ]);

    ticket.feed(2);

    ticket.cut();
    return ticket;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    printerManager.scanResults.listen((val) async {
      setState(() {
        devices = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      backgroundColor: Colors.transparent,
      body: Container(
        margin: EdgeInsets.only(top: widthScreen(context) / 3),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: medium + normal),
              padding: EdgeInsets.symmetric(
                  vertical: medium + medium, horizontal: medium),
              decoration: BoxDecoration(
                color: whiteNeutral,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(medium),
                  topRight: Radius.circular(medium),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Kertas", style: sansPro(fontWeight: FontWeight.w600)),
                  borderDropdown(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: medium),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text("Pilih Kertas"),
                          isExpanded: true,
                          value: valuePaper,
                          items: paperSizeList.map((e) {
                            return DropdownMenuItem(
                              child: Text(() {
                                if (e.width == 558) {
                                  return "Kertas 80x80 mm";
                                } else {
                                  return "Kertas 58x58 mm";
                                }
                              }()),
                              value: e,
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              valuePaper = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: normal),
                  Text("Printer", style: sansPro(fontWeight: FontWeight.w600)),
                  Expanded(
                    child: devices.length == 0
                        ? Center(
                            child: Text("Tidak ada printer, silahkan scan!!"))
                        : ListView.builder(
                            itemCount: devices.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  var statusScan = await printerManager
                                      .isScanningStream.first;
                                  if (statusScan == true) {
                                    stopScanDevices();
                                  }
                                  startPrint(devices[index]).then((value) {
                                    if (widget.afterPrint != null) {
                                      widget.afterPrint(value);
                                    }
                                  });
                                },
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 60,
                                      padding: EdgeInsets.only(left: 10),
                                      alignment: Alignment.centerLeft,
                                      child: Row(
                                        children: <Widget>[
                                          Icon(Icons.print),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Text(devices[index].name),
                                                Text(devices[index].address),
                                                Text(
                                                  'Click to print a test receipt',
                                                  style: TextStyle(
                                                      color: Colors.grey[700]),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                ),
                              );
                            }),
                  ),
                  Container(
                    height: 45,
                    margin: EdgeInsets.only(right: normal),
                    width: widthScreen(context),
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      child: Text("Cancel"),
                      color: primaryColor,
                      textColor: whiteNeutral,
                      onPressed: () {
                        Navigator.pop(context);
                        widget.afterPrint("cancel");
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 10,
              child: StreamBuilder<bool>(
                stream: printerManager.isScanningStream,
                initialData: false,
                builder: (c, snapshot) {
                  if (snapshot.data) {
                    return FloatingActionButton(
                      child: Icon(Icons.stop),
                      onPressed: stopScanDevices,
                      backgroundColor: Colors.red,
                    );
                  } else {
                    return FloatingActionButton(
                      child: Icon(Icons.search),
                      backgroundColor: primaryColor,
                      onPressed: startScanDevices,
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
