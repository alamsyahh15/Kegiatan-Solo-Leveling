import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/ui/bloc/pengambilan_bloc/pengambilan_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:provider/provider.dart';
import '../../config/export_config.dart';
import '../../config/widget.dart';

class HomeTakingPage extends StatefulWidget {
  @override
  _HomeTakingPageState createState() => _HomeTakingPageState();
}

class _HomeTakingPageState extends State<HomeTakingPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PengambilanBloc(context, key: key))
      ],
      child: Consumer<PengambilanBloc>(
        builder: (context, pengambilanBloc, _) => Scaffold(
          key: key,
          body: Container(
            child: Column(
              children: [
                HeaderSearch(
                  showAddButton: false,
                  showCheckNomor: true,
                  onSearch: (val) {
                    pengambilanBloc.search(val);
                  },
                  onReset: () {
                    pengambilanBloc.init();
                  },
                  onCancelSearch: () {
                    pengambilanBloc.init();
                  },
                  onCheckNomor: () {
                    sheetCheck(pengambilanBloc);
                  },
                  onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                      konsumenBy, kurirBy) {
                    pengambilanBloc.getDataFilterBy(
                        dateFrom, dateTo, statusBy, filterBy);
                  },
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: normal),
                    child: pengambilanBloc.isLoading
                        ? circularProgressIndicator()
                        : pengambilanBloc?.listDataPengambilan?.length == 0
                            ? notFoundDataStatus()
                            : ListView.builder(
                                itemCount: pengambilanBloc
                                    ?.listDataPengambilan?.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return itemList(pengambilanBloc, index);
                                },
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

  sheetCheck(PengambilanBloc bloc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BottomSheet(
        backgroundColor: Colors.transparent,
        onClosing: () {},
        builder: (context) => Container(
          decoration: BoxDecoration(
            color: whiteNeutral,
            boxShadow: [BoxShadow(blurRadius: small, color: greyColor)],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(medium),
              topRight: Radius.circular(medium),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: medium),
                width: widthScreen(context),
                height: 45,
                // ignore: deprecated_member_use
                child: FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    scan(bloc);
                  },
                  icon: Icon(Icons.qr_code_scanner),
                  label: Text("Barcode Scan"),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: medium, bottom: medium),
                width: widthScreen(context),
                height: 45,
                // ignore: deprecated_member_use
                child: FlatButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    dialogCheckNomor(bloc);
                  },
                  icon: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(Icons.text_fields)),
                  label: Text("Manual Code"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future scan(PengambilanBloc bloc) async {
    String barcode;
    try {
      barcode = await BarcodeScanner.scan();
      if (barcode != null) {
        bloc.checkNomorLaundry(barcode);
      }
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        showLocalSnackbar('The user did not grant the camera permission!', key);
      } else {
        showLocalSnackbar('Unknown error: $e', key);
      }
    } on FormatException {} catch (e) {
      showLocalSnackbar('Unknown error: $e', key);
    }
  }

  dialogCheckNomor(PengambilanBloc bloc) {
    String kodeTransaction = "";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Check Nomer Order",
                style: sansPro(fontWeight: FontWeight.w600, fontSize: 16)),
            Divider(thickness: 1),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              label: "No. Order",
              initialValue: kodeTransaction ?? "",
              onChanged: (val) {
                kodeTransaction = val;
              },
            ),
          ],
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(thickness: 1),
              Container(
                margin:
                    EdgeInsets.symmetric(vertical: normal, horizontal: medium),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
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
                              borderRadius: BorderRadius.circular(normal)),
                          color: primaryColor,
                          textColor: whiteNeutral,
                          child: Text("Submit"),
                          onPressed: () {
                            Navigator.pop(context);
                            bloc.checkNomorLaundry(kodeTransaction);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget itemList(PengambilanBloc bloc, int index) {
    DataOrder data = bloc?.listDataPengambilan[index];
    bool showAction = bloc?.listShowAction[index];
    return InkWell(
      onTap: () {
        bloc.hideActionButton(index);
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
                  Text(data?.tanggalJamPengambilan ?? "",
                      style: sansPro(color: greyColor)),
                  labelProgress(data.statusLaundry)
                ],
              ),
              showAction
                  ? actionOrderButton(
                      visibleCancel: false,
                      visibleComplete: false,
                      onDetail: () {
                        setState(() {
                          bloc.hideActionButton(index);
                        });
                        bloc.getDetailLaundry(data);
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
                          bloc.showActionButton(index);
                          setState(() {});
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
