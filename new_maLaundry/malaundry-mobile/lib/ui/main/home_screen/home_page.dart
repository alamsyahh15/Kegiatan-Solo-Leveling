import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' hide log;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ma_laundry/ui/config/error_connect_widget.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/data_transaction_screen/home_data_transaction_page.dart';
import 'package:ma_laundry/ui/main/inbox_screen/home_inbox_page.dart';
import 'package:ma_laundry/ui/main/kas_laundry_screen/home_kas_laundry_page.dart';
import 'package:ma_laundry/ui/main/konsumen_screen/home_konsumen_screen.dart';
import 'package:ma_laundry/ui/main/notification_screen/notification_page.dart';
import 'package:ma_laundry/ui/main/order_screen/order_page.dart';
import 'package:ma_laundry/ui/main/pembayaran_screen/home_pembayaran_page.dart';
import 'package:ma_laundry/ui/main/pengambilan_screen/home_taking_page.dart';
import 'package:ma_laundry/ui/main/pengeluaran_screen/home_pengeluaran.dart';
import 'package:ma_laundry/ui/main/registrasi_screen/home_registrasi.dart';
import 'package:ma_laundry/ui/main/request_screen/antar_screen/home_antar_page.dart';
import 'package:ma_laundry/ui/main/request_screen/jemput_screen/home_jemput_page.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:ma_laundry/utils/notification_handler.dart';
import 'package:ma_laundry/utils/whatsapp_share.dart';
import 'package:provider/provider.dart';

import 'drawer_home.dart';

TabController mainPageController;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  String titleMenu = "Registrasi";
  List<String> listNameMenu = [
    "Registrasi",
    "Pengambilan",
    "Data Order",
    "Data Transaksi Paket",
    "Pengeluaran",
    "Kas Laundry",
    "Request Jemput",
    "Request Antar",
    "Pembayaran",
    "Inbox",
    "Data Konsumen",
    "Logout"
  ];
  List<Widget> listMenu = [
    Center(child: HomeRegistrasi()), //0
    Center(child: HomeTakingPage()), //1
    Center(child: OrderPage()), //2
    Center(child: HomeDataTransactionPage()), //3
    Center(child: HomePengeluaranPage()), //4
    Center(child: HomeKasLaundryPage()), //5
    Center(child: HomeJemputPage()), //6
    Center(child: HomeAntarPage()), //7
    Center(child: HomePembayaranPage()), //8
    Center(child: HomeInboxPage()), //9
    Center(child: HomeKonsumenScreen()), //10
  ];

  handleDataNotif(String menu) {
    setState(() {
      if (menu.contains("requestjemput")) {
        mainPageController.animateTo(6);
        titleMenu = listNameMenu[6];
      }
      if (menu.contains("pembayaran")) {
        mainPageController.animateTo(8);
        titleMenu = listNameMenu[8];
      }
      if (menu.contains("pengambilan")) {
        mainPageController.animateTo(1);
        titleMenu = listNameMenu[1];
      }
      if (menu.contains("antar")) {
        mainPageController.animateTo(7);
        titleMenu = listNameMenu[7];
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainPageController = TabController(length: listMenu.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => NotificationHandler(context)),
        ChangeNotifierProvider(create: (context) => ConnecttivityHandler())
      ],
      child: Consumer<NotificationHandler>(
        builder: (context, notifBloc, _) => Consumer<ConnecttivityHandler>(
          builder: (context, connect, _) => Scaffold(
            drawer: DrawerHome(
              listNameMenu: listNameMenu,
              controller: mainPageController,
              onChangeMenu: (val) {
                setState(() => titleMenu = val);
              },
            ),
            appBar: AppBar(
              title: Text("$titleMenu",
                  style:
                      sansPro(fontSize: medium, fontWeight: FontWeight.w600)),
              actions: [
                IconButton(
                  icon: Stack(
                    children: [
                      Icon(Icons.notifications),
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: Colors.red,
                        child: Text(
                          "${notifBloc.listNotif.length}",
                          style: sansPro(
                            color: whiteNeutral,
                            fontSize: 7,
                          ),
                        ),
                      ),
                    ],
                  ),
                  onPressed: () {
                    navigateTo(context, NotificationPage(notif: notifBloc))
                        .then((value) {
                      String data =
                          value.toString().replaceAll(RegExp(r'[/,_]'), "");
                      handleDataNotif(data.toLowerCase());
                    });
                  },
                )
              ],
            ),
            body: Column(
              children: [
                errorConnectWidget(context),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: mainPageController,
                    children: listMenu.map((e) => e).toList(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
