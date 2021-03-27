import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:ma_laundry/ui/main/order_screen/detail_order_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class DataOrderBloc extends ChangeNotifier {
  /// === Constructor ===
  DataOrderBloc(this.context) {
    this.init();
  }

  /// ==== Initial ===
  init() async {
    isLoading = true;
    await getDataOrder();
    isLoading = false;
  }

  /// ==== Property ===
  List<DataOrder> listDataOrder = [];
  List<bool> listShowAction = [];
  List<DataOrder> backupListDataOrder = [];
  BuildContext context;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      _isLoading = val;
      notifyListeners();
    } catch (e) {}
  }

  /// ==== Method ====
  // Get Detail Laundry
  Future getDetailLaundry(DataOrder dataOrder) async {
    DataOrder data;
    progressDialog(context);
    var res = await orderRepo.getDetailLaundry(dataOrder);
    Navigator.pop(context);
    if (res != null) {
      data = res[0];
      navigateTo(
          context,
          DetailOrderPage(
            data: data,
            printFile: true,
          )).then((value) {
        init();
      });
    }
  }

  // Get Data Order
  Future getDataOrder() async {
    try {
      isLoading = true;
      var res = await orderRepo.getDataOrder();
      isLoading = false;
      if (res != null) {
        listShowAction.clear();
        backupListDataOrder.clear();
        listDataOrder = res;
        backupListDataOrder.addAll(listDataOrder);
        listDataOrder.forEach((element) {
          listShowAction.add(false);
        });
      }
      notifyListeners();
    } catch (e) {}
  }

  // Set Complete Data
  Future setComplete(DataOrder data) async {
    progressDialog(context);
    await orderRepo.setCompleteLaundry(data).then((value) {
      Navigator.pop(context);
      init();
    });
  }

  // Set Cancel Data
  Future setCancel(DataOrder data) async {
    dialogNoteCancel(
      context,
      onSubmit: (note) async {
        progressDialog(context);
        await orderRepo.setCanceledLaundry(data, note).then((value) {
          Navigator.pop(context);
          Navigator.pop(context);
          init();
        });
      },
    );
  }

  // Get Data Filter By
  Future getDataFilterBy(DateTime dateFrom, DateTime dateTo, String statusBy,
      String filterBy) async {
    isLoading = true;
    listDataOrder.clear();
    backupListDataOrder.clear();
    notifyListeners();
    var res = await orderRepo.getDataOrder(
        dateTo: dateTo,
        dateFrom: dateFrom,
        statusBy: statusBy,
        filterBy: filterBy);
    isLoading = false;
    if (res != null) {
      listDataOrder = res;
      backupListDataOrder.addAll(listDataOrder);
      listShowAction.clear();
      listDataOrder.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }

  // Search Data
  void search(String query) {
    listDataOrder = backupListDataOrder;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listDataOrder = listDataOrder
          .where((e) =>
              e.kodeTransaksi.toLowerCase().contains(query) ||
              e.konsumenFullName.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listDataOrder.forEach((element) {
        listShowAction.add(false);
      });
      notifyListeners();
    }
  }
}
