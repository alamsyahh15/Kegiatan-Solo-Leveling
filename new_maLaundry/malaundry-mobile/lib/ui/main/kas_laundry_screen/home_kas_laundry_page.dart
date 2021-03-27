import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/bloc/kas_laundry_bloc/kas_laundry_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/spacing.dart';
import 'package:ma_laundry/ui/main/kas_laundry_screen/list_total_laundry.dart';
import 'package:ma_laundry/utils/navigator_helper.dart';
import 'package:provider/provider.dart';

class HomeKasLaundryPage extends StatefulWidget {
  @override
  _HomeKasLaundryPageState createState() => _HomeKasLaundryPageState();
}

class _HomeKasLaundryPageState extends State<HomeKasLaundryPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => KasLaundryBloc(context, key: key))
      ],
      child: Consumer<KasLaundryBloc>(
        builder: (context, kasBloc, _) => Scaffold(
          key: key,
          body: kasBloc.isLoading
              ? circularProgressIndicator()
              : Column(
                  children: [
                    headerFilter(kasBloc),
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: normal),
                        child: ListView.builder(
                          itemCount: kasBloc.listMenu.length,
                          itemBuilder: (BuildContext context, int index) {
                            var e = kasBloc.listMenu[index];
                            return InkWell(
                              onTap: () {
                                if (index != 2 &&
                                    index != (kasBloc.listMenu.length - 1)) {
                                  navigateTo(
                                    context,
                                    ListTotalLaundry(
                                      filter: kasBloc.filterBy,
                                      type: e.nameMenu,
                                    ),
                                  ).then((value) {
                                    kasBloc.init();
                                  });
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: medium),
                                width: widthScreen(context),
                                padding: EdgeInsets.symmetric(
                                    horizontal: medium,
                                    vertical: medium + small),
                                decoration: BoxDecoration(
                                  color: e.color,
                                  borderRadius:
                                      BorderRadius.circular(normal + tiny),
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25,
                                      backgroundColor: e.baseColor,
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(normal),
                                          child: Image.asset(e.assets,
                                              width: 25, height: 25),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: medium),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            e.nameMenu,
                                            style: sansPro(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            e.total,
                                            style: sansPro(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: normal),
                  ],
                ),
        ),
      ),
    );
  }

  Widget headerFilter(KasLaundryBloc kasBloc) {
    return Container(
      width: widthScreen(context),
      padding: EdgeInsets.symmetric(vertical: normal, horizontal: normal),
      decoration: BoxDecoration(
        color: whiteNeutral,
        boxShadow: [
          BoxShadow(color: darkColor, blurRadius: normal),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: kasBloc.listFilterButton.map((e) {
          return Flexible(
            child: Container(
              margin: EdgeInsets.only(right: small, left: small),
              child: e['value']
                  ? CustomRaisedButton(
                      onPressed: () {
                        kasBloc.setButton(e);
                      },
                      title: "${e['name_button']}",
                    )
                  : CustomOutlineButton(
                      title: "${e['name_button']}",
                      onPressed: () {
                        kasBloc.setButton(e);
                      },
                    ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
