import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/main/pengeluaran_screen/form_pengeluaran_page.dart';

import 'pengeluaran_page.dart';

class HomePengeluaranPage extends StatefulWidget {
  @override
  _HomePengeluaranPageState createState() => _HomePengeluaranPageState();
}

class _HomePengeluaranPageState extends State<HomePengeluaranPage>
    with TickerProviderStateMixin {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  TabController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: [
          PengeluaranPage(tabController: controller),
          FormPengeluaranPage(tabController: controller),
        ],
      ),
    );
  }
}
