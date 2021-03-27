import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/ui/bloc/konsumen_bloc/konsumen_bloc.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/laundry_form_page.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class HomeKonsumenScreen extends StatefulWidget {
  @override
  _HomeKonsumenScreenState createState() => _HomeKonsumenScreenState();
}

class _HomeKonsumenScreenState extends State<HomeKonsumenScreen> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => KonsumenBloc(context, key: key)),
        ChangeNotifierProvider(
            create: (context) => RegistrasiBloc.addConsumer(context, key: key)),
      ],
      child: Consumer<RegistrasiBloc>(
        builder: (context, regBloc, _) => Consumer<KonsumenBloc>(
          builder: (context, konsumenBloc, _) => Scaffold(
            body: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderSearch(
                    showAddButton: true,
                    onSearch: (query) => konsumenBloc.search(query),
                    onCancelSearch: () => konsumenBloc.init(),
                    onReset: () => konsumenBloc.init(),
                    onSubmitFilter: (dateFrom, dateTo, filterBy, statusBy,
                        konsumenBy, kurirBy) {
                      konsumenBloc.filterDataBy(filterBy, dateFrom, dateTo);
                    },
                    onAddData: () {
                      showAsBottomSheet(konsumenBloc);
                    },
                  ),
                  Expanded(
                    child: konsumenBloc.isLoading
                        ? circularProgressIndicator()
                        : konsumenBloc.listDataKonsumen.length == 0
                            ? notFoundDataStatus()
                            : RefreshIndicator(
                                onRefresh: () async {
                                  konsumenBloc.init();
                                },
                                child: Container(
                                  margin: EdgeInsets.all(normal),
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        konsumenBloc.listDataKonsumen.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      DataConsumer data =
                                          konsumenBloc.listDataKonsumen[index];
                                      bool showAction =
                                          konsumenBloc.listShowAction[index];
                                      return ItemList(
                                        kodeTransaction:
                                            "${data?.title} ${data?.namaDepan} ${data?.namaBelakang}",
                                        statusProgress: "${data?.isActive}",
                                        fullName: data?.username,
                                        date: data?.telp,
                                        showAction: showAction,
                                        visibleNonaktif: true,
                                        showActionButton: () {
                                          konsumenBloc.showActionButton(index);
                                        },
                                        hideActionButton: () {
                                          konsumenBloc.hideActionButton(index);
                                        },
                                        onDetail: () {
                                          showAsBottomSheet(konsumenBloc,
                                              data: data);
                                        },
                                        onNonaktif: () async {
                                          konsumenBloc.hideActionButton(index);
                                          konsumenBloc.nonActiveKonsumen(data);
                                        },
                                      );
                                    },
                                  ),
                                ),
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

  Future showAsBottomSheet(KonsumenBloc konsumenBloc,
      {DataConsumer data}) async {
    await showSlidingBottomSheet(context, builder: (context) {
      return SlidingSheetDialog(
        elevation: 8,
        cornerRadius: 16,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.9, 0.4],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        duration: Duration(milliseconds: 800),
        scrollSpec: ScrollSpec.bouncingScroll(),
        cornerRadiusOnFullscreen: 8,
        headerBuilder: (context, state) {
          return Material(
            child: Container(
              width: widthScreen(context),
              margin: EdgeInsets.all(medium),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widthScreen(context),
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.drag_handle,
                      size: 35,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data != null ? "Update Form" : "Register Form",
                    style: sansPro(
                        fontSize: medium + normal, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          );
        },
        builder: (context, state) {
          return SlidingSheetConsumer(
            dataUpdate: data,
            onClosed: (val) async {
              konsumenBloc.init();
            },
          );
        },
      );
    }); // This is the result.
  }
}
