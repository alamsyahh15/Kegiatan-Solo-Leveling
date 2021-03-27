import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/item_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:ma_laundry/data/network/repository/pengeluaran_repository/pengeluaran_repo.dart';

import '../../config/export_config.dart';
import '../../config/widget.dart';

class PengeluaranBloc extends ChangeNotifier {
  /// ==== Constructor ====
  PengeluaranBloc(this.context, {this.key}) {
    this.init();
  }
  PengeluaranBloc.initForm(this.context, {this.key}) {
    this.initFormPengeluaran();
  }

  /// ==== Initial ====
  void init() async {
    listPengeluaran.clear();
    listBackupPengeluaran.clear();
    isLoading = true;
    await getPengeluaran();
    isLoading = false;
  }

  void initFormPengeluaran() async {
    listItem.clear();
    isLoading = true;
    await getItem();
    isLoading = false;
  }

  /// ==== Property ====
  DataPengeluaran dataCreate = DataPengeluaran();
  DataItem itemValue;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<DataPengeluaran> listPengeluaran = [], listBackupPengeluaran = [];
  List<DataItem> listItem = [];
  List<bool> listShowAction = [];
  BuildContext context;
  bool _isLoading = false, _isSubmit = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    try {
      _isLoading = val;
      notifyListeners();
    } catch (e) {}
  }

  bool get isSubmit => _isSubmit;
  set isSubmit(bool val) {
    try {
      _isSubmit = val;
      notifyListeners();
    } catch (e) {}
  }

  /// ==== Method ====

  // Get Item Data
  Future getItem() async {
    var res = await pengeluaranRepo.getItem();
    if (res is! String) {
      listItem = res;
      notifyListeners();
    }
  }

  // Cretae Pengeluaran
  Future createPengeluaran(TabController controller) async {
    progressDialog(context);
    isSubmit = true;
    var res = await pengeluaranRepo.createPengeluaran(dataCreate);
    isSubmit = false;
    itemValue = null;
    dataCreate = DataPengeluaran();
    Navigator.pop(context);
    if (res is! String) {
      controller.index = 0;
    } else {
      showLocalSnackbar(res, key);
    }
    notifyListeners();
  }

  // Get Pengeluaran
  Future getPengeluaran() async {
    try {
      var res = await pengeluaranRepo.getPengeluaran();
      if (res is! String) {
        listPengeluaran = res;
        listBackupPengeluaran.addAll(listPengeluaran);
        dscData();
      }
      notifyListeners();
    } catch (e) {}
  }

  // Get Filter By
  Future getDataFilterBy(DateTime dateFrom, DateTime dateTo, String statusBy,
      String filterBy) async {
    isLoading = true;
    listPengeluaran.clear();
    listBackupPengeluaran.clear();
    notifyListeners();
    var res = await pengeluaranRepo.getPengeluaran(
        dateTo: dateTo, dateFrom: dateFrom, filterBy: filterBy);
    isLoading = false;
    if (res is! String) {
      listPengeluaran = res;
      listBackupPengeluaran.addAll(listPengeluaran);
      dscData();
    }
    notifyListeners();
  }

  /// Search Data
  void search(String query) {
    listPengeluaran = listBackupPengeluaran;
    if (query.isNotEmpty || query != null) {
      query = query.toLowerCase();
      listPengeluaran = listPengeluaran
          .where((e) =>
              e.createdByName.toLowerCase().contains(query) ||
              e.namaItem.toLowerCase().contains(query))
          .toList();
    }
    notifyListeners();
  }

  // Descending data
  void dscData() {
    listPengeluaran.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    listBackupPengeluaran.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    listPengeluaran.forEach((element) {
      listShowAction.add(false);
    });
    notifyListeners();
  }
}
