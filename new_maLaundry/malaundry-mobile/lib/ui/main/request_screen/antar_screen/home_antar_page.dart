import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/request_model/request_antar_model.dart';
import 'package:ma_laundry/ui/bloc/request_bloc/antar_bloc/request_antar_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/request_screen/jemput_screen/home_jemput_page.dart';
import 'package:provider/provider.dart';

class HomeAntarPage extends StatefulWidget {
  @override
  _HomeAntarPageState createState() => _HomeAntarPageState();
}

class _HomeAntarPageState extends State<HomeAntarPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RequestAntarBloc(context, key: key))
      ],
      child: Consumer<RequestAntarBloc>(
        builder: (context, antarBloc, _) => RefreshIndicator(
          onRefresh: () async {
            antarBloc.init();
          },
          child: Scaffold(
            key: key,
            body: Container(
              child: Column(
                children: [
                  HeaderSearch(
                    showAddButton: false,
                    showFilterByStatus: true,
                    showFilterRequest: true,
                    onCancelSearch: () => antarBloc.init(),
                    onReset: () => antarBloc.init(),
                    onSearch: (query) => antarBloc.search(query),
                    onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                        konsumenBy, kurirBy) {
                      antarBloc.getDataFilterBy(dateFrom, dateTo, filterBy,
                          statusBy, konsumenBy, kurirBy);
                    },
                  ),
                  Expanded(
                    child: antarBloc.isLoading
                        ? circularProgressIndicator()
                        : antarBloc.listAntarData.length == 0
                            ? notFoundDataStatus()
                            : Container(
                                margin: EdgeInsets.all(normal),
                                child: ListView.builder(
                                  itemCount: antarBloc.listAntarData.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    AntarData data =
                                        antarBloc.listAntarData[index];
                                    bool showAction =
                                        antarBloc.listShowAction[index];
                                    return ItemList(
                                      kodeTransaction: data?.kode ?? " n/a",
                                      statusProgress: "${data?.status}",
                                      fullName: data?.namaKonsumen,
                                      kurirName: data?.namaKurir,
                                      date: data?.createdDate ?? "",
                                      showAction: showAction,
                                      statusKurir: data?.statusPersetujuanKurir,
                                      requestType:
                                          data?.statusPersetujuanKurir !=
                                              "DISETUJUI",
                                      showActionButton: () {
                                        antarBloc.showActionButton(index);
                                      },
                                      hideActionButton: () {
                                        antarBloc.hideActionButton(index);
                                      },
                                      onDetail: () {
                                        antarBloc
                                            .getDetailData(data.idTransaksi);
                                      },
                                      onSetKurir: () {
                                        dialogSetKurir(data, antarBloc);
                                      },
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
      ),
    );
  }

  dialogSetKurir(AntarData antarData, RequestAntarBloc bloc) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Update Kurir"),
        content: SetKurirDialog(
          dataAntar: antarData,
          onSelect: (value) {
            antarData?.idKurir = int.parse(value);
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
                      bloc.setKurir(antarData);
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
