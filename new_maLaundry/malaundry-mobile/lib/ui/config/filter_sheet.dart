import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/bloc/request_bloc/jemput_bloc/request_jemput_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:provider/provider.dart';

DateTime dateFromFilter, dateToFilter;
String filterBy, statusBy, kurirBy;
String konsumenBy;
void resetFilter() {
  dateFromFilter = null;
  dateToFilter = null;
  filterBy = null;
  statusBy = null;
  konsumenBy = null;
  kurirBy = null;
}

class FilterSheet extends StatefulWidget {
  final Function() onReset;
  final bool showFilterByStatus, showFilterRequest;
  final bool showPembayaran;
  final Function(
    DateTime dateFrom,
    DateTime dateTo,
    String filterBy,
    String statusBy,
    String konsumenBy,
    String kurirBy,
  ) onSubmit;

  const FilterSheet({
    Key key,
    @required this.onReset,
    @required this.onSubmit,
    this.showFilterByStatus = false,
    this.showFilterRequest = false,
    this.showPembayaran = false,
  }) : super(key: key);
  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RequestJemputBloc.initFilter(
            context,
            key: key,
            showReqFilter: widget.showFilterRequest,
          ),
        )
      ],
      child: Consumer<RequestJemputBloc>(
        builder: (context, jemputBloc, _) => Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            margin: EdgeInsets.only(top: widthScreen(context) / 3),
            decoration: BoxDecoration(
                color: whiteNeutral,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(medium),
                  topRight: Radius.circular(medium),
                ),
                boxShadow: [
                  BoxShadow(blurRadius: 5, spreadRadius: 5, color: greyColor)
                ]),
            child: Container(
              child: Column(
                children: [
                  Container(
                    width: widthScreen(context),
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      child: Text(
                        "FILTER",
                        style: sansPro(
                            fontWeight: FontWeight.w600, fontSize: medium),
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Divider(thickness: 1),
                  Expanded(
                    child: jemputBloc.isLoading
                        ? circularProgressIndicator()
                        : ListView(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: medium, vertical: normal),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text("Date From",
                                        style: sansPro(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                    InkWell(
                                      onTap: () async {
                                        var res = await showDatePicker(
                                            context: context,
                                            initialDate: dateFromFilter ??
                                                DateTime.now(),
                                            firstDate: firstDate,
                                            lastDate: lastDate);
                                        if (res != null) {
                                          setState(() {
                                            dateFromFilter = res;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: medium),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                "${formatDate(dateFromFilter)}"),
                                            Icon(Icons.date_range,
                                                color: primaryColor),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: greyColor),
                                            borderRadius:
                                                BorderRadius.circular(normal)),
                                      ),
                                    ),
                                    SizedBox(height: medium),
                                    Text("Date To",
                                        style: sansPro(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                    InkWell(
                                      onTap: () async {
                                        var res = await showDatePicker(
                                            context: context,
                                            initialDate:
                                                dateToFilter ?? DateTime.now(),
                                            firstDate: firstDate,
                                            lastDate: lastDate);
                                        if (res != null) {
                                          setState(() {
                                            dateToFilter = res;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10, horizontal: medium),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("${formatDate(dateToFilter)}"),
                                            Icon(Icons.date_range,
                                                color: primaryColor),
                                          ],
                                        ),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: greyColor),
                                            borderRadius:
                                                BorderRadius.circular(normal)),
                                      ),
                                    ),
                                    SizedBox(height: medium),
                                    Text("Filter",
                                        style: sansPro(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600)),
                                    borderDropdown(
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: medium),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text("Filter By"),
                                            value: filterBy,
                                            items: FILTER_BY.map((e) {
                                              return DropdownMenuItem(
                                                child: Text("$e"),
                                                value: e,
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                            onChanged: (val) {
                                              setState(() => filterBy = val);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    ///Fliter Status
                                    Visibility(
                                      visible: widget.showFilterByStatus,
                                      child: SizedBox(height: medium),
                                    ),
                                    Visibility(
                                      visible: widget.showFilterByStatus,
                                      child: Text("Status",
                                          style: sansPro(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Visibility(
                                      visible: widget.showFilterByStatus,
                                      child: borderDropdown(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: medium),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: Text("Status"),
                                              value: statusBy,
                                              items: widget.showPembayaran
                                                  ? PAYMENT_STATUS.map((e) {
                                                      return DropdownMenuItem(
                                                        child: Text("$e"),
                                                        value: e,
                                                      );
                                                    }).toList()
                                                  : FILTER_STATUS.map((e) {
                                                      return DropdownMenuItem(
                                                        child: Text("$e"),
                                                        value: e,
                                                      );
                                                    }).toList(),
                                              isExpanded: true,
                                              onChanged: (val) {
                                                setState(() => statusBy = val);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                                    /// Fliter For Request Antar Jemput
                                    Visibility(
                                        visible: widget.showFilterRequest,
                                        child: SizedBox(height: medium)),
                                    Visibility(
                                      visible: widget.showFilterRequest,
                                      child: Text("Konsumen",
                                          style: sansPro(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Visibility(
                                      visible: widget.showFilterRequest,
                                      child: borderDropdown(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: medium),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: Text("Konsumen"),
                                              value: konsumenBy,
                                              items: jemputBloc.listConsumer
                                                  .map((e) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                      "${e.namaDepan} ${e.namaBelakang}"),
                                                  value: "${e.idKonsumen}",
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              onChanged: (val) {
                                                setState(
                                                    () => konsumenBy = val);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: widget.showFilterRequest,
                                      child: SizedBox(height: medium),
                                    ),
                                    Visibility(
                                      visible: widget.showFilterRequest,
                                      child: Text("Kurir",
                                          style: sansPro(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                    Visibility(
                                      visible: widget.showFilterRequest,
                                      child: borderDropdown(
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: medium),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton(
                                              hint: Text("Kurir"),
                                              value: kurirBy,
                                              items:
                                                  jemputBloc.listKurir.map((e) {
                                                return DropdownMenuItem(
                                                  child: Text(
                                                      "${e.namaDepan} ${e.namaBelakang}"),
                                                  value: "${e.id}",
                                                );
                                              }).toList(),
                                              isExpanded: true,
                                              onChanged: (val) {
                                                setState(() => kurirBy = val);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),

                  // Button ACtion
                  Divider(thickness: 1),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: medium),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: medium),
                            width: widthScreen(context),
                            height: 45,
                            // ignore: deprecated_member_use
                            child: OutlineButton(
                              child: Text("Reset"),
                              textColor: primaryColor,
                              borderSide: BorderSide(color: primaryColor),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(small)),
                              onPressed: () {
                                setState(() {
                                  resetFilter();
                                });
                                Navigator.pop(context);
                                if (widget.onReset != null) {
                                  widget.onReset();
                                }
                              },
                            ),
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: medium),
                            width: widthScreen(context),
                            height: 45,
                            // ignore: deprecated_member_use
                            child: RaisedButton(
                              child: Text("Submit"),
                              color: primaryColor,
                              textColor: whiteNeutral,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(small)),
                              onPressed: () async {
                                Navigator.pop(context);
                                widget.onSubmit(dateFromFilter, dateToFilter,
                                    filterBy, statusBy, konsumenBy, kurirBy);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
