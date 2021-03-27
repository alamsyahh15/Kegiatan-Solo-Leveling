import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/request_model/request_antar_model.dart';
import 'package:ma_laundry/data/model/request_model/request_jemput_model.dart';
import 'package:ma_laundry/ui/bloc/request_bloc/jemput_bloc/request_jemput_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:provider/provider.dart';

class HomeJemputPage extends StatefulWidget {
  @override
  _HomeJemputPageState createState() => _HomeJemputPageState();
}

class _HomeJemputPageState extends State<HomeJemputPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RequestJemputBloc(context, key: key))
      ],
      child: Consumer<RequestJemputBloc>(
        builder: (context, jemputBloc, _) => Scaffold(
          key: key,
          body: Container(
            child: Column(
              children: [
                HeaderSearch(
                  showAddButton: false,
                  showFilterByStatus: true,
                  showFilterRequest: true,
                  onCancelSearch: () => jemputBloc.init(),
                  onReset: () => jemputBloc.init(),
                  onSearch: (query) => jemputBloc.search(query),
                  onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                      konsumenBy, kurirBy) {
                    jemputBloc.getDataFilterBy(dateFrom, dateTo, filterBy,
                        statusBy, konsumenBy, kurirBy);
                  },
                ),
                Expanded(
                  child: jemputBloc.isLoading
                      ? circularProgressIndicator()
                      : jemputBloc.listDataJemput.length == 0
                          ? notFoundDataStatus()
                          : Container(
                              margin: EdgeInsets.all(normal),
                              child: ListView.builder(
                                itemCount: jemputBloc.listDataJemput.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DataJemput data =
                                      jemputBloc.listDataJemput[index];
                                  bool showAction =
                                      jemputBloc.listShowAction[index];
                                  return ItemList(
                                    kodeTransaction:
                                        data?.namaKonsumen ?? "n/a",
                                    statusProgress: data?.status,
                                    fullName: data?.namaKurir ?? "n/a",
                                    date: data?.createdDate ?? "",
                                    statusKurir: data?.statusPersetujuanKurir,
                                    showAction: () {
                                      if (data?.statusPersetujuanKurir !=
                                              "DISETUJUI" &&
                                          data?.status != "CANCELED") {
                                        return showAction;
                                      } else {
                                        return true;
                                      }
                                    }(),
                                    requestType: data?.statusPersetujuanKurir !=
                                            "DISETUJUI" &&
                                        data?.status != "CANCELED",
                                    visibleDetail: false,
                                    showActionButton: () {
                                      jemputBloc.showActionButton(index);
                                    },
                                    hideActionButton: () {
                                      jemputBloc.hideActionButton(index);
                                    },
                                    onSetKurir: () {
                                      dialogSetKurir(data, jemputBloc);
                                    },
                                    onDetail: () {},
                                  );
                                },
                              ),
                            ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  dialogSetKurir(DataJemput dataJemput, RequestJemputBloc bloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Kurir"),
        content: SetKurirDialog(
          dataJemput: dataJemput,
          onSelect: (value) {
            dataJemput?.idKurir = int.parse(value);
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: normal),
            width: widthScreen(context),
            child: Row(
              children: [
                Flexible(
                  child: CustomOutlineButton(
                    title: "Close",
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: normal),
                Flexible(
                  child: CustomRaisedButton(
                    title: "Submit",
                    onPressed: () {
                      bloc.setKurir(dataJemput);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SetKurirDialog extends StatefulWidget {
  final Function(dynamic value) onSelect;
  final DataJemput dataJemput;
  final AntarData dataAntar;
  const SetKurirDialog(
      {Key key, this.onSelect, this.dataJemput, this.dataAntar})
      : super(key: key);
  @override
  _SetKurirDialogState createState() => _SetKurirDialogState();
}

class _SetKurirDialogState extends State<SetKurirDialog> {
  String idKurir;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget?.dataJemput?.idKurir != null) {
      idKurir = widget?.dataJemput?.idKurir.toString();
    }
    if (widget?.dataAntar?.idKurir != null) {
      idKurir = widget?.dataAntar?.idKurir.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RequestJemputBloc.initKurir(context))
      ],
      child: Consumer<RequestJemputBloc>(
        builder: (context, jemputBloc, _) => jemputBloc.isLoading
            ? Container(
                width: widthScreen(context),
                height: 50,
                child: circularProgressIndicator())
            : Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Kurir"),
                    SizedBox(height: small),
                    borderDropdown(
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: medium),
                          child: DropdownButton(
                            isExpanded: true,
                            value: idKurir,
                            hint: Text("Select Kurir"),
                            items: jemputBloc.listKurir.map((e) {
                              return DropdownMenuItem(
                                child:
                                    Text("${e?.namaDepan} ${e?.namaBelakang}"),
                                value: "${e.id}",
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                widget.onSelect(value);
                                idKurir = value;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
