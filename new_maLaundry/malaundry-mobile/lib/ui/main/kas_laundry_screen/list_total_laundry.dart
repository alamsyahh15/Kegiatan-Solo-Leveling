import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:ma_laundry/ui/bloc/kas_laundry_bloc/kas_laundry_bloc.dart';
import 'package:ma_laundry/ui/config/error_connect_widget.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/kas_laundry_screen/detail_kas_page.dart';
import 'package:ma_laundry/ui/main/pengeluaran_screen/detail_pengeluaran_page.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:provider/provider.dart';

class ListTotalLaundry extends StatefulWidget {
  String filter, type;

  ListTotalLaundry({Key key, this.filter, this.type}) : super(key: key);
  @override
  _ListTotalLaundryState createState() => _ListTotalLaundryState();
}

class _ListTotalLaundryState extends State<ListTotalLaundry> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool isSearch = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => KasLaundryBloc.initListKas(
                  context,
                  filter: widget.filter,
                  type: widget.type,
                )),
        ChangeNotifierProvider(create: (context) => ConnecttivityHandler())
      ],
      child: Consumer<KasLaundryBloc>(
        builder: (context, kasBloc, _) => Consumer<ConnecttivityHandler>(
          builder: (context, connect, child) => Scaffold(
            key: key,
            appBar: AppBar(
              leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text("Kas Laundry"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                errorConnectWidget(context),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                            width: widthScreen(context),
                            padding: EdgeInsets.symmetric(
                                vertical: normal, horizontal: normal),
                            decoration: BoxDecoration(
                              color: whiteNeutral,
                              boxShadow: [
                                BoxShadow(color: darkColor, blurRadius: normal),
                              ],
                            ),
                            child: CustomTextField(
                              hint: "Search....",
                              controller: controller,
                              prefixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  controller.clear();
                                  FocusScope.of(context).unfocus();
                                  kasBloc.initListKas(
                                      widget.type, widget.filter);
                                },
                              ),
                              onChanged: (val) {
                                kasBloc.search(val, widget.type);
                              },
                            )),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: normal),
                            child: kasBloc.isLoading
                                ? circularProgressIndicator()
                                : () {
                                    if (widget.type.toUpperCase() ==
                                        "TOTAL LAUNDRY") {
                                      return kasBloc.listLaundry.length == 0;
                                    } else if (widget.type.toUpperCase() ==
                                        "TOTAL PENGELUARAN") {
                                      return kasBloc.listPengeluaran.length ==
                                          0;
                                    } else {
                                      return kasBloc.listDataKas.length == 0;
                                    }
                                  }()
                                    ? notFoundDataStatus()
                                    : Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: normal),
                                        child: ListView.builder(
                                          itemCount: () {
                                            if (widget.type.toUpperCase() ==
                                                "TOTAL LAUNDRY") {
                                              return kasBloc.listLaundry.length;
                                            } else if (widget.type
                                                    .toUpperCase() ==
                                                "TOTAL PENGELUARAN") {
                                              return kasBloc
                                                  .listPengeluaran.length;
                                            } else {
                                              return kasBloc.listDataKas.length;
                                            }
                                          }(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return itemList(kasBloc, index);
                                          },
                                        ),
                                      ),
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
      ),
    );
  }

  Widget itemList(KasLaundryBloc kasBloc, int index) {
    if (widget.type.toUpperCase() == "TOTAL LAUNDRY") {
      DataOrder data = kasBloc.listLaundry[index];
      bool showAction = kasBloc.listShowAction[index];
      return InkWell(
        onTap: () {
          kasBloc.hideActionButton(index);
        },
        child: Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.kodeTransaksi ?? "n/a",
                      style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(data?.konsumenFullName ?? "n/a",
                        style: sansPro(color: greyColor)),
                    Text(data?.tanggalJam, style: sansPro(color: greyColor)),
                  ],
                ),
                showAction
                    ? actionOrderButton(
                        visibleCancel: false,
                        visibleComplete: false,
                        onDetail: () {
                          kasBloc.hideActionButton(index);
                          setState(() {});
                          kasBloc.getDetailLaundry(data);
                        },
                      )
                    : Container(
                        height: 40,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          textColor: whiteNeutral,
                          color: primaryColor,
                          child: Row(
                            children: [
                              Text("Action"),
                              Icon(Icons.keyboard_arrow_down, size: 15)
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              kasBloc.showActionButton(index);
                            });
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    } else if (widget.type.toUpperCase() == "TOTAL PENGELUARAN") {
      DataPengeluaran data = kasBloc.listPengeluaran[index];
      bool showAction = kasBloc.listShowAction[index];
      return InkWell(
        onTap: () {
          kasBloc.hideActionButton(index);
        },
        child: Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.createdByName ?? "n/a",
                      style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(data?.namaItem ?? "n/a",
                        style: sansPro(color: greyColor)),
                    Text(data?.createdDate ?? "n/a",
                        style: sansPro(color: greyColor)),
                  ],
                ),
                showAction
                    ? actionOrderButton(
                        visibleCancel: false,
                        visibleComplete: false,
                        onDetail: () {
                          kasBloc.hideActionButton(index);
                          setState(() {});
                          showPengeluaran(data);
                        },
                      )
                    : Container(
                        height: 40,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          textColor: whiteNeutral,
                          color: primaryColor,
                          child: Row(
                            children: [
                              Text("Action"),
                              Icon(Icons.keyboard_arrow_down, size: 15)
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              kasBloc.showActionButton(index);
                            });
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    } else {
      DataTransaction data = kasBloc.listDataKas[index];
      bool showAction = kasBloc.listShowAction[index];
      return InkWell(
        onTap: () {
          kasBloc.hideActionButton(index);
        },
        child: Card(
          elevation: 5,
          child: Container(
            margin: EdgeInsets.all(medium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.kodeTransaksi ?? "n/a",
                      style: sansPro(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                    Text(data?.namaKonsumen ?? "n/a",
                        style: sansPro(color: greyColor)),
                    Text(data?.createdDate ?? "",
                        style: sansPro(color: greyColor)),
                  ],
                ),
                showAction
                    ? actionOrderButton(
                        visibleCancel: false,
                        visibleComplete: false,
                        onDetail: () {
                          kasBloc.hideActionButton(index);
                          setState(() {});
                          showDetail(data);
                        },
                      )
                    : Container(
                        height: 40,
                        // ignore: deprecated_member_use
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(normal)),
                          textColor: whiteNeutral,
                          color: primaryColor,
                          child: Row(
                            children: [
                              Text("Action"),
                              Icon(Icons.keyboard_arrow_down, size: 15)
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              kasBloc.showActionButton(index);
                            });
                          },
                        ),
                      ),
              ],
            ),
          ),
        ),
      );
    }
  }

  showPengeluaran(DataPengeluaran data) async {
    key.currentState.showBottomSheet(
      (context) => DetailPengeluaran(
        data: data,
      ),
    );
  }

  showDetail(DataTransaction data) {
    key.currentState.showBottomSheet(
      (context) => DetailKasPage(
        data: data,
        type: widget.type,
      ),
    );
  }
}
