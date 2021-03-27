import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/pembayaran_model/detail_pembayaran_model.dart';
import 'package:ma_laundry/data/model/pembayaran_model/pembayaran_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/data/network/repository/pembayaran_repository/pembayaran_repository.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:ma_laundry/ui/main/order_screen/detail_order_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class PembayaranBloc extends ChangeNotifier {
  /// ==== Constructor ====
  PembayaranBloc(this.context, {this.key}) {
    this.init();
  }

  PembayaranBloc.approvalInit(this.context,
      {this.key, bool showPembayaran, DataOrder data}) {
    if (showPembayaran) {
      this.approvalInit(data);
    }
  }

  /// ==== Initial ====
  void init() async {
    isLoading = true;
    await getPembayaran();
    isLoading = false;
  }

  void approvalInit(DataOrder data) async {
    isLoading = true;
    await getDetailPembayaran(data);
    isLoading = false;
  }

  /// ==== Property ====
  PembayaranData pembayaranData;
  List<bool> listViewAction = [];
  List<DataPembayaran> listDataPembayaran = [], backupListDataPembayaran = [];
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      _isLoading = val;
      notifyListeners();
    } catch (e) {}
  }

  /// ==== Method ====
  // Get Detail Pembayaran
  Future getDetailPembayaran(DataOrder data) async {
    var res = await pembayaranRepo.getDetailPembayaran(data);
    if (res is! String) {
      try {
        pembayaranData = res;
      } catch (e) {}
    } else {
      showLocalSnackbar(res, key);
    }
  }

  // Aprroval Pembayaran
  Future approvalPembayaran(String statusAction, String note) async {
    progressDialog(context);
    var res = await pembayaranRepo.approveRejectPembayaran(
      pembayaranData,
      statusAction,
      note,
    );
    Navigator.pop(context);
    if (res is! String) {
      Navigator.pop(context);
      Navigator.pop(context);
    } else {
      showLocalSnackbar(res, key);
    }
  }

  // Get Detail Laundry
  Future getDetailLaundry(int idTransaksi) async {
    DataOrder dataOrder = DataOrder(idTransaksi: idTransaksi);
    DataOrder data;
    progressDialog(context);
    var res = await orderRepo.getDetailLaundry(dataOrder);
    Navigator.pop(context);
    if (res != null) {
      data = res[0];
      navigateTo(context, DetailOrderPage(data: data, showPembayaran: true))
          .then((value) {
        init();
      });
    }
  }

  //GET Pembayaran
  Future getPembayaran() async {
    try {
      reset();
      var res = await pembayaranRepo.getDataPembayaran();
      if (res is! String) {
        listDataPembayaran = res;
        backupListDataPembayaran.addAll(listDataPembayaran);
        listDataPembayaran.forEach((element) {
          listViewAction.add(false);
        });
      } else {
        showLocalSnackbar(res, key);
      }
    } catch (e) {}
  }

  // Get Data Filter By
  Future getDataFilterBy(DateTime dateFrom, DateTime dateTo, String statusBy,
      String filterBy) async {
    isLoading = true;
    reset();
    var res = await pembayaranRepo.getDataPembayaran(
        dateTo: dateTo,
        dateFrom: dateFrom,
        statusBy: statusBy,
        filterBy: filterBy);
    isLoading = false;
    if (res != null) {
      listDataPembayaran = res;
      backupListDataPembayaran.addAll(listDataPembayaran);
      listViewAction.clear();
      listDataPembayaran.forEach((element) {
        listViewAction.add(false);
      });
    }
    notifyListeners();
  }

  // Search Data
  void search(String query) {
    listDataPembayaran = backupListDataPembayaran;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listDataPembayaran = listDataPembayaran
          .where((e) =>
              e.kodeTransaksi.toLowerCase().contains(query) ||
              e.konsumenFullName.toLowerCase().contains(query))
          .toList();
      listViewAction.clear();
      listDataPembayaran.forEach((element) {
        listViewAction.add(false);
      });
      notifyListeners();
    }
  }

  // Show Hide Action Button
  showActionButton(int index) {
    for (int a = 0; a < listViewAction.length; a++) {
      listViewAction[a] = false;
    }
    listViewAction[index] = true;
    notifyListeners();
  }

  hideActionButton(int index) {
    for (int a = 0; a < listViewAction.length; a++) {
      listViewAction[a] = false;
    }
    listViewAction[index] = false;
    notifyListeners();
  }

  // Reset
  void reset() {
    listDataPembayaran.clear();
    backupListDataPembayaran.clear();
    listViewAction.clear();
  }
}
