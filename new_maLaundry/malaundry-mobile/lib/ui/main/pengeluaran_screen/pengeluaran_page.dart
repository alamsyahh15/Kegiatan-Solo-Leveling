import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:ma_laundry/ui/bloc/pengeluaran_bloc/pengeluaran_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/pengeluaran_screen/detail_pengeluaran_page.dart';
import 'package:provider/provider.dart';

import '../../config/colors.dart';

class PengeluaranPage extends StatefulWidget {
  final TabController tabController;
  const PengeluaranPage({Key key, this.tabController}) : super(key: key);
  @override
  _PengeluaranPageState createState() => _PengeluaranPageState();
}

class _PengeluaranPageState extends State<PengeluaranPage> {
  bool isSearch = false;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PengeluaranBloc(context))
      ],
      child: Consumer<PengeluaranBloc>(
        builder: (context, pengeluaranBloc, _) => RefreshIndicator(
          onRefresh: () async {
            pengeluaranBloc.init();
          },
          child: Scaffold(
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    HeaderSearch(
                      onReset: () {
                        pengeluaranBloc.init();
                      },
                      onAddData: () {
                        widget.tabController.index = 1;
                        setState(() {});
                      },
                      onSearch: (query) {
                        pengeluaranBloc.search(query);
                      },
                      onCancelSearch: () {
                        pengeluaranBloc.init();
                      },
                      onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                          konsumenBy, kurirBy) {
                        pengeluaranBloc.getDataFilterBy(
                            dateFrom, dateTo, statusBy, filterBy);
                      },
                    ),
                    Expanded(
                      child: pengeluaranBloc.isLoading
                          ? circularProgressIndicator()
                          : pengeluaranBloc?.listPengeluaran?.length == 0
                              ? notFoundDataStatus()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: normal, vertical: normal),
                                  child: ListView.builder(
                                    itemCount:
                                        pengeluaranBloc.listPengeluaran.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DataPengeluaran data = pengeluaranBloc
                                          .listPengeluaran[index];
                                      bool showAction =
                                          pengeluaranBloc.listShowAction[index];
                                      return InkWell(
                                        onTap: () {
                                          pengeluaranBloc
                                              .listShowAction[index] = false;
                                          setState(() {});
                                        },
                                        child: Card(
                                          elevation: 5,
                                          child: Container(
                                            margin: EdgeInsets.all(medium),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      data?.createdByName ??
                                                          "n/a",
                                                      style: sansPro(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                        data?.namaItem ?? "n/a",
                                                        style: sansPro(
                                                            color: greyColor)),
                                                    Text(
                                                        data?.createdDate ??
                                                            "-",
                                                        style: sansPro(
                                                            color: greyColor)),
                                                  ],
                                                ),
                                                showAction
                                                    ? actionOrderButton(
                                                        visibleCancel: false,
                                                        visibleComplete: false,
                                                        onDetail: () async {
                                                          pengeluaranBloc
                                                                  .listShowAction[
                                                              index] = false;
                                                          setState(() {});
                                                          showDetail(data);
                                                        },
                                                      )
                                                    : Container(
                                                        height: 40,
                                                        // ignore: deprecated_member_use
                                                        child: RaisedButton(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          normal)),
                                                          textColor:
                                                              whiteNeutral,
                                                          color: primaryColor,
                                                          child: Row(
                                                            children: [
                                                              Text("Action"),
                                                              Icon(
                                                                  Icons
                                                                      .keyboard_arrow_down,
                                                                  size: 15)
                                                            ],
                                                          ),
                                                          onPressed: () {
                                                            pengeluaranBloc
                                                                    .listShowAction[
                                                                index] = true;
                                                            setState(() {});
                                                          },
                                                        ),
                                                      ),
                                              ],
                                            ),
                                          ),
                                        ),
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
      ),
    );
  }

  showDetail(DataPengeluaran data) {
    showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => DetailPengeluaran(data: data),
    );
  }
}
