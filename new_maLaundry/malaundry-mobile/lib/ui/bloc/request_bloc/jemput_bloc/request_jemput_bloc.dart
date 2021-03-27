import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/model/request_model/kurir_model.dart';
import 'package:ma_laundry/data/model/request_model/request_jemput_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/data/network/repository/request_repository/jemput_repository/request_jemput_repository.dart';
import 'package:ma_laundry/ui/config/export_config.dart';

class RequestJemputBloc extends ChangeNotifier {
  /// ==== Constructor ====
  RequestJemputBloc(this.context, {this.key}) {
    this.init();
  }
  RequestJemputBloc.initFilter(this.context, {this.key, bool showReqFilter}) {
    if (showReqFilter) {
      this.initFilter();
    }
  }
  RequestJemputBloc.initKurir(this.context) {
    this.initKurir();
  }

  /// ==== Initial ====

  void init() async {
    isLoading = true;
    await getRequestJemput();
    isLoading = false;
  }

  void initFilter() async {
    isLoading = true;
    await getSearchConsumer();
    await getKurir();
    isLoading = false;
  }

  void initKurir() async {
    isLoading = true;
    await getKurir();
    isLoading = false;
  }

  /// ==== Property ====
  List<DataConsumer> listConsumer = [];
  List<DataKurir> listKurir = [];
  List<DataJemput> listDataJemput = [], backupListDataJemput = [];
  List<bool> listShowAction = [];
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

  /// Get Consumer
  Future getSearchConsumer() async {
    try {
      listConsumer.clear();
      var res = await registrasiFormRepo.searchDataConsumer();
      if (res is! String) {
        listConsumer = res.data;
      } else {
        showLocalSnackbar(res, key);
      }
      notifyListeners();
    } catch (e) {}
  }

  /// Set Kurir
  Future setKurir(DataJemput dataJemput) async {
    progressDialog(context);
    var res = await requestJemputRepo.setKurir(dataJemput);
    Navigator.pop(context);
    Navigator.pop(context);
    if (res is! String) {
      showLocalSnackbar(res['message'], key);
    } else {
      showLocalSnackbar('$res', key);
    }
    init();
  }

  /// Get Kurir
  Future getKurir() async {
    try {
      listKurir.clear();
      var res = await requestJemputRepo.getKurir();
      if (res is! String) {
        listKurir = res;
      } else {
        showLocalSnackbar("$res", key);
      }
      notifyListeners();
    } catch (e) {}
  }

  // Get Request Jemput
  Future getRequestJemput() async {
    try {
      reset();
      var res = await requestJemputRepo.getRequestJemput();
      if (res is String) {
        showLocalSnackbar("$res", key);
      } else {
        listDataJemput = res;
        backupListDataJemput.addAll(listDataJemput);
        listDataJemput.forEach((element) {
          listShowAction.add(false);
        });
      }
      notifyListeners();
    } catch (e) {}
  }

  //Filter Data
  Future getDataFilterBy(
    DateTime dateFrom,
    DateTime dateTo,
    String filterBy,
    String statusBy,
    String idKonsumen,
    String idKurir,
  ) async {
    isLoading = true;

    notifyListeners();
    var res = await requestJemputRepo.getRequestJemput(
        dateTo: dateTo,
        dateFrom: dateFrom,
        filterBy: filterBy,
        idKonsumen: idKonsumen,
        statusBy: statusBy,
        idKurir: idKurir);
    isLoading = false;
    if (res is! String) {
      listDataJemput = res;
      backupListDataJemput.addAll(listDataJemput);
      listDataJemput.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }

  // Search Data
  void search(String query) {
    listDataJemput = backupListDataJemput;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listDataJemput = listDataJemput
          .where((e) =>
              e.namaKonsumen.toLowerCase().contains(query) ||
              e.namaKurir.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listDataJemput.forEach((element) {
        listShowAction.add(false);
      });
      notifyListeners();
    }
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

  // Reset method
  void reset() {
    listDataJemput.clear();
    backupListDataJemput.clear();
    listShowAction.clear();
    notifyListeners();
  }
}
