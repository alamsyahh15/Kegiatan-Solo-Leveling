import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/menu_kas_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/total_kas_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/data/network/repository/kas_laundry_repository/kas_laundry_repository.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/order_screen/detail_order_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class KasLaundryBloc extends ChangeNotifier {
  /// ==== Constructor ====
  KasLaundryBloc(this.context, {this.key}) {
    this.init();
  }
  KasLaundryBloc.initListKas(this.context,
      {this.key, String type, String filter}) {
    this.initListKas(type, filter);
  }

  /// ==== Initial ====
  void init() async {
    isLoading = true;
    listMenu.clear();
    await getTotalKas("Today");
    isLoading = false;
  }

  void initListKas(String type, String filter) async {
    isLoading = true;
    await getDataKas(type, filter);
    isLoading = false;
  }

  /// ==== Property ====
  List<MenuKasModel> listMenu = [];
  List listFilterButton = [
    {"name_button": "Today", "value": true},
    {"name_button": "Yesterday & Today", "value": false}
  ];
  List<DataTransaction> listDataKas = [], backupListDataKas = [];
  List<DataOrder> listLaundry = [], backupListLaundry = [];
  List<DataPengeluaran> listPengeluaran = [], backupPengeluaran = [];
  List<bool> listShowAction = [];
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String filterBy;
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
      navigateTo(context, DetailOrderPage(data: data, printFile: true))
          .then((value) {
        init();
      });
    }
  }

  // Get Total Kas
  Future getTotalKas(String filter) async {
    try {
      var res = await kasLaundryRepo.getTotalKas(filter);
      if (res is! String) {
        TotalKasModel data = res;
        listMenu = [
          MenuKasModel(
            nameMenu: "Total Laundry",
            baseColor: Color(0xFF2F80ED),
            total: data.totalLaundry,
            assets: "assets/images/income_icon.png",
            color: Color(0xFFD5E6FB),
          ),
          MenuKasModel(
            nameMenu: "Total Paket",
            baseColor: Color(0xFF2F80ED),
            total: data.totalPaket,
            assets: "assets/images/income_icon.png",
            color: Color(0xFFD5E6FB),
          ),
          MenuKasModel(
            nameMenu: "Total Transfer",
            baseColor: Color(0xFFEB5757),
            total: data.totalTransfer,
            assets: "assets/images/total_icon.png",
            color: Color(0xFFFBDDDD),
          ),
          MenuKasModel(
            nameMenu: "Total Pengeluaran",
            baseColor: Color(0xFFF2C94C),
            total: data.totalPengeluaran,
            assets: "assets/images/expenses_icon.png",
            color: Color(0xFFF2C94C).withOpacity(0.25),
          ),
          MenuKasModel(
            nameMenu: "Total Saldo",
            baseColor: Color(0xFF27AE60),
            total: data.totalSaldo,
            assets: "assets/images/total_icon.png",
            color: Color(0xFFD3EADD),
          ),
        ];
      } else {
        showLocalSnackbar(res, key);
      }
      notifyListeners();
    } catch (e) {}
  }

  /// Get Data Kas
  Future getDataKas(String type, String filter) async {
    try {
      type = type.toUpperCase();
      type = type.replaceAll("TOTAL ", "");
      var res = await kasLaundryRepo.getDataKas(filter, type);
      if (res is String) {
        showLocalSnackbar(res, key);
      } else {
        if (type == "LAUNDRY") {
          listLaundry = res;
          log("Data ${listLaundry.toList()}");
          backupListLaundry.addAll(listLaundry);
          listLaundry.forEach((e) {
            listShowAction.add(false);
          });
        } else if (type == "PENGELUARAN") {
          listPengeluaran = res;
          backupPengeluaran.addAll(listPengeluaran);
          listPengeluaran.forEach((e) {
            listShowAction.add(false);
          });
        } else {
          listDataKas = res;
          backupListDataKas.addAll(listDataKas);
          listDataKas.forEach((e) {
            listShowAction.add(false);
          });
        }
      }
      notifyListeners();
    } catch (e) {}
  }

  // SetButton
  setButton(Map<String, dynamic> data) async {
    try {
      listFilterButton.forEach((e) {
        e['value'] = false;
      });
      data['value'] = true;
      isLoading = true;
      listMenu.clear();
      filterBy = data['name_button'];
      if (filterBy != "Today") {
        filterBy = "";
      }
      await getTotalKas(filterBy);
      isLoading = false;
      notifyListeners();
    } catch (e) {}
  }

  // Search
  void search(String query, String type) {
    if (type.toUpperCase() != "TOTAL LAUNDRY") {
      listDataKas = backupListDataKas;
      if (query != null || query.isNotEmpty) {
        query = query.toLowerCase();
        listDataKas = listDataKas
            .where((e) =>
                e.kodeTransaksi.toLowerCase().contains(query) ||
                e.namaKonsumen.toLowerCase().contains(query))
            .toList();
      }
    } else if (type.toUpperCase() == "TOTAL PENGELUARAN") {
      listPengeluaran = backupPengeluaran;
      if (query != null || query.isNotEmpty) {
        listPengeluaran = listPengeluaran
            .where((e) =>
                e.createdByName.toLowerCase().contains(query) ||
                e.namaItem.toLowerCase().contains(query))
            .toList();
      }
    } else {
      listLaundry = backupListLaundry;
      listLaundry = listLaundry
          .where((e) =>
              e.kodeTransaksi.toLowerCase().contains(query) ||
              e.konsumenFullName.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listLaundry.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }

  // Show Hide Action Button
  showActionButton(int index) {
    for (int a = 0; a < listShowAction.length; a++) {
      listShowAction[a] = false;
    }
    listShowAction[index] = true;
    notifyListeners();
  }

  hideActionButton(int index) {
    for (int a = 0; a < listShowAction.length; a++) {
      listShowAction[a] = false;
    }
    listShowAction[index] = false;
    notifyListeners();
  }
}
