import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/pembayaran_model/detail_pembayaran_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/ui/bloc/pembayaran_bloc/pembayaran_bloc.dart';
import 'package:ma_laundry/ui/bloc/pengambilan_bloc/pengambilan_bloc.dart';
import 'package:ma_laundry/ui/config/error_connect_widget.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/order_screen/list_kiloan_widget.dart';
import 'package:ma_laundry/ui/main/order_screen/list_satuan_widget.dart';
import 'package:ma_laundry/ui/main/pembayaran_screen/detail_pembayaran.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:ma_laundry/utils/pdf_creator.dart';
import 'package:ma_laundry/utils/whatsapp_share.dart';
import 'package:provider/provider.dart';

class DetailOrderPage extends StatefulWidget {
  final DataOrder data;
  final bool fromPengambilan;
  final bool showPembayaran;
  final bool printFile;

  const DetailOrderPage({
    Key key,
    this.data,
    this.fromPengambilan = false,
    this.showPembayaran = false,
    this.printFile = false,
  }) : super(key: key);
  @override
  _DetailOrderPageState createState() => _DetailOrderPageState();
}

class _DetailOrderPageState extends State<DetailOrderPage> with PdfCreator {
  DataOrder get data => widget.data;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<List<String>> listInputKilos = [], listInputUnit = [];
  bool showSatuan = true, showKilos = true, showDetail = true;
  setKembalian() {
    data?.kembalian = int.parse(
        "${(double.parse(data?.jumlahBayar) - double.parse(data?.sisaTagihan)).round()}");
    if ((data?.kembalian ?? 0) < 0) {
      data?.kembalian = 0;
    }
  }

  init() {
    setState(() {
      if (widget.fromPengambilan == true) {
        showSatuan = false;
        showKilos = false;
        showDetail = false;
        if (data?.sisaTagihan != null) {
          data?.jumlahBayar = data?.sisaTagihan;
          setKembalian();
        }
      }

      listInputKilos.clear();
      listInputUnit.clear();
      if ((data?.kiloan?.length ?? 0) > 0) {
        data?.kiloan?.forEach((a) {
          List<String> newList = [
            a?.namaService ?? "-",
            a?.jumlah ?? "-",
            formatMoney(a?.hargaService),
            formatMoney(a?.totalHargaItem)
          ];
          listInputKilos.add(newList);
        });
      }
      if ((data?.satuan?.length ?? 0) > 0) {
        data?.satuan?.forEach((a) {
          List<String> newList = [
            a?.namaService ?? "-",
            a?.jumlah ?? "-",
            formatMoney(a?.hargaService),
            formatMoney(a?.totalHargaItem)
          ];
          listInputUnit.add(newList);
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PengambilanBloc.takeOrder(context, key: key)),
        ChangeNotifierProvider(
            create: (context) => PembayaranBloc.approvalInit(
                  context,
                  key: key,
                  showPembayaran: widget.showPembayaran,
                  data: widget.data,
                )),
        ChangeNotifierProvider(create: (context) => ConnecttivityHandler())
      ],
      child: Consumer<PengambilanBloc>(
        builder: (context, pengambilanBloc, _) => Consumer<PembayaranBloc>(
          builder: (context, pembayaranBloc, _) =>
              Consumer<ConnecttivityHandler>(
            builder: (context, connect, _) => Scaffold(
              key: key,
              body: SafeArea(
                child: Column(
                  children: [
                    errorConnectWidget(context),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: normal, vertical: medium),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(normal)),
                            elevation: 5,
                            child: Column(
                              children: [
                                AppBar(
                                  backgroundColor: whiteNeutral,
                                  centerTitle: true,
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: darkColor,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  title: Text(
                                    "Summary ${data?.statusPersetujuan ?? ""}",
                                    style: sansPro(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: darkColor),
                                  ),
                                ),
                                SizedBox(height: medium),

                                /// List Kiloan
                                ListKiloanWidget(
                                    listInputKilos: listInputKilos),

                                /// List Satuan
                                ListSatuanWidget(listInputUnit: listInputUnit),

                                /// Detail Order
                                Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: medium),
                                  width: widthScreen(context),
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: normal),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: greyColor, width: 1),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(medium),
                                          decoration: BoxDecoration(
                                              color: greyNeutral,
                                              border: Border.all(
                                                  color: greyColor, width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      normal)),
                                          child: InkWell(
                                            onTap: () {
                                              setState(() {
                                                showDetail = !showDetail;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Detail Order",
                                                  style: sansPro(),
                                                ),
                                                Icon(showDetail
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible: showDetail,
                                          child: Container(
                                            padding: EdgeInsets.all(medium),
                                            child: Column(
                                              children: [
                                                detailItem2(
                                                  context,
                                                  title: "Nomer Order",
                                                  content:
                                                      data?.kodeTransaksi ??
                                                          "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Tanggal Masuk",
                                                  content:
                                                      data?.tanggalJam ?? "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Nama Customer",
                                                  content:
                                                      data?.konsumenFullName ??
                                                          "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Kuota Cuci Terpakai",
                                                  content:
                                                      (data.kuotaCuciUsed ??
                                                              "-") +
                                                          " Kg",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title:
                                                      "Kuota Setrika Terpakai",
                                                  content:
                                                      (data.kuotaSetrikaUsed ??
                                                              "-") +
                                                          " Pcs",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Parfum",
                                                  content: data?.parfum ?? "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Luntur",
                                                  content: data?.luntur ?? "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Tas Kantong",
                                                  content:
                                                      data?.tasKantong ?? "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Catatan ",
                                                  content: data?.catatan ==
                                                          "null"
                                                      ? "-"
                                                      : data?.catatan ?? "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Status Pembayaran",
                                                  content: data?.statusTagihan,
                                                  styleContent: sansPro(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        data?.statusTagihan ==
                                                                "BELUM LUNAS"
                                                            ? Colors.red
                                                            : Colors.black,
                                                  ),
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Metode Pembayaran",
                                                  content:
                                                      data?.metodePembayaran ??
                                                          "-",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Total Tagihan",
                                                  content:
                                                      "${formatMoney(data?.totalTagihan ?? "0")}",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Jumlah Bayar",
                                                  content:
                                                      "${formatMoney(data?.jumlahBayar ?? "0")}",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Sisa Tagihan",
                                                  content:
                                                      "${formatMoney(data?.sisaTagihan ?? "0")}",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Diskon",
                                                  content:
                                                      "${formatMoney(data?.diskon ?? "0")}",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Kembalian",
                                                  content:
                                                      "${formatMoney(data?.kembalian ?? "0")}",
                                                ),
                                                detailItem2(
                                                  context,
                                                  title: "Status Laundry",
                                                  content:
                                                      data?.statusLaundry ??
                                                          "-",
                                                ),
                                                Visibility(
                                                  visible:
                                                      data?.catatanCancel !=
                                                          null,
                                                  child: detailItem2(
                                                    context,
                                                    title: "Catatan Cancel",
                                                    content:
                                                        data?.catatanCancel ??
                                                            "-",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Visibility(
                                  visible: widget?.fromPengambilan,
                                  child: Column(
                                    children: [
                                      Divider(thickness: 1),
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        child: Column(
                                          children: [
                                            CustomTextField(
                                              label: "Sisa tagihan",
                                              hint:
                                                  "${data?.sisaTagihan ?? "-"}",
                                              readOnly: true,
                                            ),
                                            SizedBox(height: medium),
                                            CustomTextField(
                                              label: "Bayar",
                                              initialValue:
                                                  data?.jumlahBayar ?? "",
                                              onChanged: (val) {
                                                if (val.isNotEmpty) {
                                                  data?.jumlahBayar = val;
                                                  setKembalian();
                                                  setState(() {});
                                                }
                                              },
                                            ),
                                            SizedBox(height: medium),
                                            CustomTextField(
                                              label: "Kembalian",
                                              hint: "${data?.kembalian ?? "-"}",
                                              readOnly: true,
                                            ),
                                            SizedBox(height: medium),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    height: 45,
                                                    width: widthScreen(context),
                                                    // ignore: deprecated_member_use
                                                    child: OutlineButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      normal)),
                                                      borderSide: BorderSide(
                                                          color: primaryColor),
                                                      textColor: primaryColor,
                                                      child: Text("Back"),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: medium),
                                                Flexible(
                                                  child: Container(
                                                    height: 45,
                                                    width: widthScreen(context),
                                                    // ignore: deprecated_member_use
                                                    child: RaisedButton(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      normal)),
                                                      color: primaryColor,
                                                      textColor: whiteNeutral,
                                                      child: Text("Submit"),
                                                      onPressed: () {
                                                        pengambilanBloc
                                                            .ambilLaundryOrder(
                                                                data);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: medium),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /// Detail Pembayaran
                                Visibility(
                                  visible: widget.showPembayaran,
                                  child: pembayaranBloc.isLoading
                                      ? circularProgressIndicator()
                                      : DetailPembayaran(
                                          dataPembayaran:
                                              pembayaranBloc.pembayaranData),
                                ),

                                /// Print File
                                Row(
                                  children: [
                                    Visibility(
                                      visible: widget.printFile,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        alignment: Alignment.centerLeft,
                                        height: 45,
                                        // ignore: deprecated_member_use
                                        child: RaisedButton.icon(
                                          color: primaryColor,
                                          textColor: whiteNeutral,
                                          label: Text("Print"),
                                          icon: Icon(Icons.print),
                                          onPressed: () {
                                            printDocument(
                                              key,
                                              dataOrder: data,
                                              onClosing: (value) {
                                                snackbarHandler(value);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.printFile,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        alignment: Alignment.centerLeft,
                                        height: 45,
                                        // ignore: deprecated_member_use
                                        child: RaisedButton.icon(
                                          color: primaryColor,
                                          textColor: whiteNeutral,
                                          label: Text("Send to customer"),
                                          icon: Icon(Icons.send),
                                          onPressed: () async {
                                            progressDialog(context);
                                            final result =
                                                await createPdf(data);
                                            Navigator.pop(context);
                                            shareWhatsapp(data, result);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: medium),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Visibility(
                visible: data?.statusPersetujuan == "MENUNGGU",
                child: BottomAppBar(
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: medium, vertical: normal),
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                              height: 45,
                              width: widthScreen(context),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(normal)),
                                color: primaryColor,
                                textColor: whiteNeutral,
                                child: Text("Approve"),
                                onPressed: () {
                                  dialogApproval("APPROVE", pembayaranBloc);
                                },
                              ),
                            ),
                          ),
                          SizedBox(width: medium),
                          Flexible(
                            child: Container(
                              height: 45,
                              width: widthScreen(context),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(normal)),
                                color: Colors.red,
                                textColor: whiteNeutral,
                                child: Text("Reject"),
                                onPressed: () {
                                  dialogApproval("REJECT", pembayaranBloc);
                                },
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  snackbarHandler(dynamic value) {
    if (value != null) {
      if (value == "cancel") {
        showLocalSnackbar("Cancel Printed", key);
      } else {
        showLocalSnackbar("Complete Printed", key);
      }
    } else {
      showLocalSnackbar("Failed Printed ", key);
    }
  }

  dialogApproval(String statusAction, PembayaranBloc bloc) {
    PembayaranData data = bloc.pembayaranData;
    String note;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Information $statusAction",
          style: sansPro(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  buktiPhotoUrl(
                      data.laundry.kodeTransaksi, data.pembayaran.buktiBayar),
                  height: 100,
                  width: widthScreen(context),
                  fit: BoxFit.fill,
                ),
                Divider(thickness: 1),
                SizedBox(height: normal),
                CustomTextField(
                  label: "Catatan",
                  hint: "Catatan....",
                  minLines: 1,
                  maxLines: 8,
                  onChanged: (val) {
                    note = val;
                  },
                ),
                SizedBox(height: medium),
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        height: 45,
                        width: widthScreen(context),
                        // ignore: deprecated_member_use
                        child: OutlineButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          textColor: statusAction == "APPROVE"
                              ? primaryColor
                              : Colors.red,
                          borderSide: BorderSide(
                            color: statusAction == "APPROVE"
                                ? primaryColor
                                : Colors.red,
                          ),
                          child: Text("Close"),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),
                    SizedBox(width: medium),
                    Flexible(
                      child: Container(
                        height: 45,
                        width: widthScreen(context),
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          color: statusAction == "APPROVE"
                              ? primaryColor
                              : Colors.red,
                          textColor: whiteNeutral,
                          child: Text("$statusAction".toLowerCase().inCaps),
                          onPressed: () {
                            bloc.approvalPembayaran(statusAction, note);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
