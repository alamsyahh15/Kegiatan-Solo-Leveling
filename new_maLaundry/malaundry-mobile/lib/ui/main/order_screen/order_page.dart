import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/ui/bloc/order_bloc/data_order_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  bool isSearch = false;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataOrderBloc(context))
      ],
      child: Consumer<DataOrderBloc>(
        builder: (context, orderBloc, _) => RefreshIndicator(
          onRefresh: () async {
            orderBloc.init();
          },
          child: Scaffold(
            body: SafeArea(
              child: Container(
                child: Column(
                  children: [
                    HeaderSearch(
                      showFilterByStatus: true,
                      showAddButton: false,
                      onReset: () async {
                        await orderBloc.init();
                      },
                      onCancelSearch: () => orderBloc.init(),
                      onSearch: (query) => orderBloc.search(query),
                      onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                          konsumenBy, kurirBy) async {
                        await orderBloc?.getDataFilterBy(
                            dateFrom, dateTo, statusBy, filterBy);
                      },
                    ),
                    Expanded(
                      child: orderBloc.isLoading
                          ? circularProgressIndicator()
                          : orderBloc?.listDataOrder?.length == 0
                              ? notFoundDataStatus()
                              : Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: normal, vertical: normal),
                                  child: ListView.builder(
                                    itemCount:
                                        orderBloc?.listDataOrder?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DataOrder data =
                                          orderBloc?.listDataOrder[index];
                                      bool showAction =
                                          orderBloc?.listShowAction[index];
                                      return InkWell(
                                        onTap: () {
                                          orderBloc?.listShowAction[index] =
                                              false;
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
                                                      data?.kodeTransaksi ??
                                                          "n/a",
                                                      style: sansPro(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 16),
                                                    ),
                                                    Text(
                                                        data?.konsumenFullName ??
                                                            "n/a",
                                                        style: sansPro(
                                                            color: greyColor)),
                                                    Text(
                                                        data?.estPengambilan ??
                                                            "",
                                                        style: sansPro(
                                                            color: greyColor)),
                                                    labelProgress(
                                                        data?.statusLaundry ??
                                                            "n/a")
                                                  ],
                                                ),
                                                showAction
                                                    ? actionOrderButton(
                                                        visibleCancel:
                                                            data?.statusLaundry ==
                                                                "PROGRESS",
                                                        visibleComplete:
                                                            data?.statusLaundry ==
                                                                "PROGRESS",
                                                        onDetail: () async {
                                                          orderBloc
                                                              .getDetailLaundry(
                                                                  data);
                                                        },
                                                        onComplete: () {
                                                          orderBloc.setComplete(
                                                              data);
                                                        },
                                                        onCancel: () {
                                                          orderBloc
                                                              .setCancel(data);
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
                                                            orderBloc
                                                                    ?.listShowAction[
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
