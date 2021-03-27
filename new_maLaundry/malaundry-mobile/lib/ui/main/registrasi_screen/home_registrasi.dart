import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/bloc/registrasi_laundry_bloc/registrasi_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/additional_form_page.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/laundry_form_page.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/payment_detail_page.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/service_kilos_page.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/service_satuan_page.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/summary_laundy_page.dart';
import 'package:ma_laundry/utils/navigator_helper.dart';
import 'package:provider/provider.dart';

TabController tabControllerRegistration;

class HomeRegistrasi extends StatefulWidget {
  @override
  _HomeRegistrasiState createState() => _HomeRegistrasiState();
}

class _HomeRegistrasiState extends State<HomeRegistrasi>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabControllerRegistration = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => RegistrasiBloc(context, key: key))
      ],
      child: Consumer<RegistrasiBloc>(builder: (context, regBloc, _) {
        return Scaffold(
          key: key,
          body: regBloc.isLoading
              ? circularProgressIndicator()
              : TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: tabControllerRegistration,
                  children: [
                    LaundryFormPage(registrasiBloc: regBloc),
                    ServiceKilosPage(registrasiBloc: regBloc),
                    ServiceSatuanPage(registrasiBloc: regBloc),
                    AddtionalFormPage(registrasiBloc: regBloc),
                    PaymentDetailPage(registrasiBloc: regBloc),
                  ],
                ),
          bottomNavigationBar: BottomAppBar(
            child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: medium, vertical: normal),
                child: Row(
                  children: [
                    Visibility(
                      visible: tabControllerRegistration.index > 0,
                      child: Flexible(
                        child: Container(
                          height: 45,
                          width: widthScreen(context),
                          // ignore: deprecated_member_use
                          child: OutlineButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(normal)),
                            borderSide: BorderSide(color: primaryColor),
                            color: whiteNeutral,
                            textColor: primaryColor,
                            child: Text("Back"),
                            onPressed: () {
                              setState(() {
                                FocusScope.of(context).unfocus();
                                var index = tabControllerRegistration.index - 1;
                                tabControllerRegistration.animateTo(index,
                                    duration: Duration(milliseconds: 200),
                                    curve: Curves.bounceInOut);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                        visible: tabControllerRegistration.index > 0,
                        child: SizedBox(width: medium)),
                    tabControllerRegistration.index == 4
                        ? Flexible(
                            child: Container(
                              height: 45,
                              width: widthScreen(context),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(normal)),
                                color: primaryColor,
                                textColor: whiteNeutral,
                                child: Text("Finish"),
                                onPressed: () async {
                                  regBloc?.countSisaTagihan();
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    navigateTo(
                                        context,
                                        SummaryLaundryPage(
                                            registrasiBloc: regBloc));
                                    tabControllerRegistration.animateTo(0,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.bounceInOut);
                                  });
                                },
                              ),
                            ),
                          )
                        : Flexible(
                            child: Container(
                              height: 45,
                              width: widthScreen(context),
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(normal)),
                                color: primaryColor,
                                textColor: whiteNeutral,
                                child: Text("Next"),
                                onPressed: () {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    regBloc?.countSisaTagihan();
                                    var index =
                                        tabControllerRegistration.index + 1;
                                    log("Res $index");
                                    if (index == 4 &&
                                        double.parse(
                                                regBloc?.totalTagihan ?? "0") ==
                                            0) {
                                      navigateTo(
                                          context,
                                          SummaryLaundryPage(
                                              registrasiBloc: regBloc));
                                      tabControllerRegistration.animateTo(0,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.bounceInOut);
                                    } else {
                                      tabControllerRegistration.animateTo(index,
                                          duration: Duration(milliseconds: 200),
                                          curve: Curves.bounceInOut);
                                    }
                                  });
                                },
                              ),
                            ),
                          )
                  ],
                )),
          ),
        );
      }),
    );
  }
}
