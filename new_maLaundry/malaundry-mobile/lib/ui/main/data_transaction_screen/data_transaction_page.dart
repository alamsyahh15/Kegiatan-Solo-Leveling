import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/ui/bloc/data_transaction_bloc/data_transaction_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:ma_laundry/ui/main/kas_laundry_screen/detail_kas_page.dart';
import 'package:provider/provider.dart';

class DataTransactionPage extends StatefulWidget {
  final TabController tabController;

  const DataTransactionPage({Key key, this.tabController}) : super(key: key);
  @override
  _DataTransactionPageState createState() => _DataTransactionPageState();
}

class _DataTransactionPageState extends State<DataTransactionPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => DataTransactionBloc(context, key: key))
      ],
      child: Consumer<DataTransactionBloc>(
        builder: (context, transcBloc, _) => Scaffold(
          key: key,
          body: SafeArea(
            child: Container(
              child: Column(
                children: [
                  HeaderSearch(
                    showFilterByStatus: false,
                    onAddData: () {
                      widget.tabController.index = 1;
                      setState(() {});
                    },
                    onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                        konsumenBy, kurirBy) {
                      transcBloc.filterDataBy(filterBy, dateFrom, dateTo);
                    },
                    onReset: () {
                      transcBloc.init();
                    },
                    onCancelSearch: () {
                      transcBloc.init();
                    },
                    onSearch: (val) {
                      transcBloc.search(val);
                    },
                  ),
                  Expanded(
                    child: transcBloc.isLoading
                        ? circularProgressIndicator()
                        : transcBloc.listTransac.length == 0
                            ? notFoundDataStatus()
                            : Container(
                                child: ListView.builder(
                                  itemCount: transcBloc.listTransac.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    DataTransaction data =
                                        transcBloc.listTransac[index];
                                    bool showAction =
                                        transcBloc.listShowAction[index];
                                    return ItemList(
                                      date: data.createdDate,
                                      fullName: data?.namaKonsumen,
                                      kodeTransaction: data?.kodeTransaksi,
                                      showAction: showAction,
                                      hideActionButton: () {
                                        transcBloc.hideActionButton(index);
                                      },
                                      showActionButton: () {
                                        transcBloc.showActionButton(index);
                                      },
                                      onDetail: () {
                                        transcBloc.hideActionButton(index);
                                        showDetail(data);
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

  showDetail(DataTransaction data) {
    key.currentState.showBottomSheet(
      (context) => DetailKasPage(
        data: data,
        type: "Data Transaksi",
      ),
    );
  }
}
