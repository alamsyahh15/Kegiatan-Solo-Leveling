import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/pembayaran_model/pembayaran_model.dart';
import 'package:ma_laundry/ui/bloc/pembayaran_bloc/pembayaran_bloc.dart';
import 'package:ma_laundry/ui/config/item_list.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:provider/provider.dart';

class HomePembayaranPage extends StatefulWidget {
  @override
  _HomePembayaranPageState createState() => _HomePembayaranPageState();
}

class _HomePembayaranPageState extends State<HomePembayaranPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => PembayaranBloc(context, key: key))
      ],
      child: Consumer<PembayaranBloc>(
        builder: (context, pembayaranBloc, _) => Scaffold(
          body: Container(
            child: Column(
              children: [
                HeaderSearch(
                  showAddButton: false,
                  showPembayaran: true,
                  showFilterByStatus: true,
                  onReset: () => pembayaranBloc.init(),
                  onCancelSearch: () => pembayaranBloc.init(),
                  onSearch: (query) => pembayaranBloc.search(query),
                  onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                      konsumenBy, kurirBy) {
                    pembayaranBloc.getDataFilterBy(
                        dateFrom, dateTo, statusBy, filterBy);
                  },
                ),
                Expanded(
                  child: pembayaranBloc.isLoading
                      ? circularProgressIndicator()
                      : pembayaranBloc.listDataPembayaran.length == 0
                          ? notFoundDataStatus()
                          : Container(
                              child: ListView.builder(
                                itemCount:
                                    pembayaranBloc.listDataPembayaran.length,
                                itemBuilder: (BuildContext context, int index) {
                                  DataPembayaran data =
                                      pembayaranBloc.listDataPembayaran[index];
                                  bool showAction =
                                      pembayaranBloc.listViewAction[index];
                                  return ItemList(
                                    kodeTransaction: data?.kodeTransaksi,
                                    fullName: data?.konsumenFullName,
                                    statusProgress: data?.statusPersetujuan,
                                    date: data?.tanggalJam,
                                    showAction: showAction,
                                    showActionButton: () {
                                      pembayaranBloc.showActionButton(index);
                                    },
                                    hideActionButton: () {
                                      pembayaranBloc.hideActionButton(index);
                                    },
                                    onDetail: () {
                                      pembayaranBloc
                                          .getDetailLaundry(data.idTransaksi);
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
    );
  }
}
