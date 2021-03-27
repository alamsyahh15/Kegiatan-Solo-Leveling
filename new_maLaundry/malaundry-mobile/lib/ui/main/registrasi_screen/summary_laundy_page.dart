import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_kiloan_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_satuan_model.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/error_connect_widget.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/home_screen/home_page.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:provider/provider.dart';

import 'home_registrasi.dart';

class SummaryLaundryPage extends StatefulWidget {
  final RegistrasiBloc registrasiBloc;

  const SummaryLaundryPage({Key key, this.registrasiBloc}) : super(key: key);
  @override
  _SummaryLaundryPageState createState() => _SummaryLaundryPageState();
}

class _SummaryLaundryPageState extends State<SummaryLaundryPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool isSubmited = true;
  RegistrasiBloc get regBloc => widget.registrasiBloc;
  List<List<String>> listInputKilos = [], listInputUnit = [];
  bool showSatuan = true, showKilos = true, showDetail = true;

  init() {
    if (this.mounted) {
      setState(() {
        initUsedQuota();
        listInputKilos.clear();
        listInputUnit.clear();
        regBloc.listInputKilos.forEach((a) {
          List<DataKiloan> tempList = regBloc.listBackupKilos
              .where((b) => a.idServiceKiloan == b.idServiceKiloan)
              .toList();
          if ((tempList?.length ?? 0) > 0) {
            List<String> newList = [
              a?.namaService ?? "-",
              a?.berat ?? "-",
              formatMoney(tempList[0]?.harga ?? "0"),
              "${formatMoney((double.parse(a?.berat ?? "0") * double.parse(tempList[0]?.harga ?? "0")))}"
            ];
            listInputKilos.add(newList);
          }
        });

        regBloc.listInputUnit.forEach((a) {
          List<DataSatuan> tempList = regBloc.listBackupUnit
              .where((b) => a.idServiceSatuan == b.idServiceSatuan)
              .toList();
          if ((tempList?.length ?? 0) > 0) {
            List<String> newList = [
              a?.namaService ?? "",
              a?.jumlah ?? "",
              formatMoney(tempList[0]?.harga ?? "0"),
              "${formatMoney((double.parse(a?.jumlah ?? "0") * double.parse(tempList[0]?.harga ?? "0")))}"
            ];
            listInputUnit.add(newList);
          }
        });
      });
    }
  }

  initUsedQuota() {
    if (double.parse(regBloc?.totalTagihan ?? "0") == 0) {
      regBloc?.billingStatusVal = "LUNAS";
      regBloc?.paymentMethodVal = "CASH";
      regBloc?.jumlahPembayaran = "0";
      regBloc?.kembalian = "0";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnecttivityHandler())
      ],
      child: Consumer<ConnecttivityHandler>(
        builder: (context, connect, _) => WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            regBloc?.billingStatusVal = null;
            regBloc?.paymentMethodVal = null;
            regBloc?.jumlahPembayaran = "0";
            regBloc?.kembalian = "0";
            return null;
          },
          child: Scaffold(
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
                                    regBloc?.billingStatusVal = null;
                                    regBloc?.paymentMethodVal = null;
                                    regBloc?.jumlahPembayaran = "0";
                                    regBloc?.kembalian = "0";
                                    Navigator.pop(context);
                                  },
                                ),
                                title: Text(
                                  "Summary",
                                  style: sansPro(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: darkColor),
                                ),
                              ),
                              SizedBox(height: medium),
                              Visibility(
                                visible: listInputKilos?.length != 0,
                                child: Container(
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
                                                showKilos = !showKilos;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Service Kiloan",
                                                  style: sansPro(),
                                                ),
                                                Icon(Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: showKilos,
                                            child: SizedBox(height: medium)),
                                        Visibility(
                                          visible: showKilos,
                                          child: Container(
                                            margin: EdgeInsets.all(medium),
                                            child: Column(
                                              children: [
                                                Table(
                                                  border: TableBorder.all(),
                                                  children: [
                                                    TableRow(children: [
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Nama Paket',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Kg',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Harga',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Subtotal',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                    border: TableBorder.all(),
                                                    children: listInputKilos
                                                        .map((e) => TableRow(
                                                            children: e
                                                                .map(
                                                                  (b) =>
                                                                      TableCell(
                                                                          child:
                                                                              Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      '$b',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  )),
                                                                )
                                                                .toList()))
                                                        .toList()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: listInputUnit?.length != 0,
                                child: Container(
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
                                                showSatuan = !showSatuan;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  "Service Satuan",
                                                  style: sansPro(),
                                                ),
                                                Icon(Icons.keyboard_arrow_down)
                                              ],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: showSatuan,
                                            child: SizedBox(height: medium)),
                                        Visibility(
                                          visible: showSatuan,
                                          child: Container(
                                            margin: EdgeInsets.all(medium),
                                            child: Column(
                                              children: [
                                                Table(
                                                  border: TableBorder.all(),
                                                  children: [
                                                    TableRow(children: [
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Nama Paket',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Pcs',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Harga',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                      TableCell(
                                                          child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Subtotal',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      )),
                                                    ]),
                                                  ],
                                                ),
                                                Table(
                                                    border: TableBorder.all(),
                                                    children: listInputUnit
                                                        .map((e) => TableRow(
                                                            children: e
                                                                .map(
                                                                  (b) =>
                                                                      TableCell(
                                                                          child:
                                                                              Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      '$b',
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    ),
                                                                  )),
                                                                )
                                                                .toList()))
                                                        .toList()),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: medium),
                                width: widthScreen(context),
                                child: Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: normal),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: greyColor, width: 1),
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
                                                BorderRadius.circular(normal)),
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              showDetail = !showDetail;
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Detail Order",
                                                style: sansPro(),
                                              ),
                                              Icon(Icons.keyboard_arrow_down)
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
                                                title: "Nama Customer",
                                                content:
                                                    "${regBloc?.valDataConsumer?.namaDepan ?? ""} ${regBloc?.valDataConsumer?.namaBelakang ?? "-"}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Kuota Cuci Terpakai",
                                                content:
                                                    "${(regBloc?.washingQuotaUsed ?? "-")} Kg",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Kuota Setrika Terpakai",
                                                content:
                                                    "${(regBloc?.setrikaQuotaUsed ?? "-")} Pcs",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Sisa Kuota Cuci",
                                                content:
                                                    "${(double.parse(regBloc?.valDataConsumer?.kuotaCuci ?? "0") - double.parse(regBloc?.washingQuotaUsed ?? "0")).round()} Kg",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Sisa Kuota Setrika",
                                                content:
                                                    "${(double.parse(regBloc?.valDataConsumer?.kuotaSetrika ?? "0") - double.parse(regBloc?.setrikaQuotaUsed ?? "0")).round()} Pcs",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Parfum",
                                                content:
                                                    "${regBloc?.valParfume?.labelParfum ?? "-"}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Luntur",
                                                content: regBloc.lunturVal
                                                    ? "YA"
                                                    : "TIDAK" ?? "-",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Tas Kantong",
                                                content: regBloc.tasKantongVal
                                                    ? "YA"
                                                    : "TIDAK" ?? "-",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Catatan",
                                                content:
                                                    "${regBloc?.noteVal ?? "-"}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Status Pembayaran",
                                                content:
                                                    "${regBloc?.billingStatusVal ?? "-"}",
                                                styleContent: sansPro(
                                                  color:
                                                      regBloc?.billingStatusVal ==
                                                              "BELUM LUNAS"
                                                          ? Colors.red
                                                          : Colors.black54,
                                                  fontWeight:
                                                      regBloc?.billingStatusVal ==
                                                              "BELUM LUNAS"
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                ),
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Metode Pembayaran",
                                                content:
                                                    "${regBloc?.paymentMethodVal ?? "-"}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Jumlah Bayar",
                                                content:
                                                    "${formatMoney(regBloc?.jumlahPembayaran ?? "0")}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Sisa Tagihan",
                                                content:
                                                    "${formatMoney(regBloc?.sisaTagihan ?? "0")}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Diskon",
                                                content:
                                                    "${formatMoney(regBloc?.diskon ?? "0")}",
                                              ),
                                              detailItem2(
                                                context,
                                                title: "Kembalian",
                                                content:
                                                    "${formatMoney(regBloc?.kembalian ?? "0")}",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
            bottomNavigationBar: BottomAppBar(
              child: Visibility(
                visible: isSubmited,
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
                            child: OutlineButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(normal)),
                              borderSide: BorderSide(color: primaryColor),
                              color: whiteNeutral,
                              textColor: primaryColor,
                              child: Text("Cancel"),
                              onPressed: () {
                                navigateRemoveUntil(context, HomePage());
                                tabControllerRegistration.animateTo(0,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.bounceInOut);
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
                                  borderRadius: BorderRadius.circular(normal)),
                              color: primaryColor,
                              textColor: whiteNeutral,
                              child: Text("Submit"),
                              onPressed: () async {
                                setState(() => isSubmited = false);
                                if (regBloc?.validation() == true) {
                                  regBloc.createLaundry(regBloc).then((value) {
                                    if (value != null) {
                                      printDocument(
                                        key,
                                        dataOrder: value,
                                        onClosing: (value) {
                                          snackbarHandler(value);
                                          setState(() {
                                            mainPageController.index = 2;
                                          });
                                        },
                                      );
                                    }
                                  });
                                } else {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) => Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(medium),
                                        topRight: Radius.circular(medium),
                                      )),
                                      elevation: 5,
                                      child: validationWidget(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        )
                      ],
                    )),
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

  Widget validationWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(medium),
          topRight: Radius.circular(medium),
        ),
      ),
      margin: EdgeInsets.all(medium),
      padding: EdgeInsets.symmetric(vertical: medium),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Silahkan Periksa Data Mandatory Berikut : ",
            style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Visibility(
            visible: (regBloc?.listInputKilos?.length ?? 0) == 0 ||
                (regBloc?.listCheckItemUnit?.length ?? 0) == 0,
            child: Column(
              children: [
                SizedBox(height: medium),
                Text("* Belum mengisi Service Kiloan atau\n  Service Satuan"),
              ],
            ),
          ),
          Visibility(
            visible: regBloc?.valParfume == null,
            child: Column(
              children: [
                SizedBox(height: medium),
                Text("* Belum memilih parfum"),
              ],
            ),
          ),
          Visibility(
            visible: regBloc?.valDataConsumer?.username == null,
            child: Column(
              children: [
                SizedBox(height: medium),
                Text("* Belum memilih Konsumen"),
              ],
            ),
          ),
          Visibility(
            visible: regBloc?.billingStatusVal == null,
            child: Column(
              children: [
                SizedBox(height: medium),
                Text("* Belum memilih Status Tagihan"),
              ],
            ),
          ),
          Visibility(
            visible: regBloc?.paymentMethodVal == null,
            child: Column(
              children: [
                SizedBox(height: medium),
                Text("* Belum memilih Metode Pembayaran"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
