import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/main/data_transaction_screen/data_transaction_page.dart';
import 'package:ma_laundry/ui/main/data_transaction_screen/form_data_transaction_page.dart';

class HomeDataTransactionPage extends StatefulWidget {
  @override
  _HomeDataTransactionPageState createState() =>
      _HomeDataTransactionPageState();
}

class _HomeDataTransactionPageState extends State<HomeDataTransactionPage>
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
          DataTransactionPage(tabController: controller),
          FormDataTransactionPage(tabController: controller),
        ],
      ),
    );
  }
}
