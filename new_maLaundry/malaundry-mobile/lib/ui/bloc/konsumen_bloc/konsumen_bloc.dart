import 'dart:io';

import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/network/repository/konsumen_repository/konsumen_repository.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:flutter/material.dart';
import '../../../data/network/repository/konsumen_repository/konsumen_repository.dart';
import '../../config/widget.dart';
import 'package:flutter/foundation.dart';

class KonsumenBloc extends ChangeNotifier {
  /// ==== Constructor ====
  KonsumenBloc(this.context, {this.key}) {
    this.init();
  }
  KonsumenBloc.initUpdate(this.context);

  /// ==== Initial ====
  void init() async {
    isLoading = true;
    await getKonsumen();
    isLoading = false;
  }

  /// ==== Property ====
  List<DataConsumer> listDataKonsumen = [], listBackup = [];
  List<bool> listShowAction = [];
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isLoading;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// ==== Method ====

  // Update Konsumen
  Future updateKonsumen(DataConsumer data, File image) async {
    var res = await konsumenRepo.updateKonsumen(data, image: image);
    return res;
  }

  // Get Konsumen
  Future getKonsumen() async {
    reset();
    var res = await konsumenRepo.getKonsumen();
    if (res is! String) {
      listDataKonsumen = res;
      listBackup.addAll(listDataKonsumen);
      listDataKonsumen.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      listDataKonsumen.forEach((element) {
        listShowAction.add(false);
      });
      notifyListeners();
    } else {
      showLocalSnackbar(res, key);
    }
  }

  /// Search Konsumen
  void search(String query) {
    listDataKonsumen = listBackup;
    listDataKonsumen = listDataKonsumen
        .where((e) =>
            e.namaBelakang.toLowerCase().contains(query) ||
            e.namaDepan.toLowerCase().contains(query) ||
            e.telp == query ||
            e.username.toLowerCase().contains(query))
        .toList();
    listShowAction.clear();
    listDataKonsumen.forEach((element) {
      listShowAction.add(false);
    });
    notifyListeners();
  }

  // Filter by
  Future filterDataBy(
      String filterBy, DateTime dateFrom, DateTime dateTo) async {
    isLoading = true;
    reset();
    var res = await konsumenRepo.getKonsumen(
      dateFrom: dateFrom,
      dateTo: dateTo,
      filter: filterBy,
    );
    isLoading = false;
    if (res is String) {
      showLocalSnackbar(res, key);
    } else {
      listDataKonsumen = res;
      listBackup.addAll(listDataKonsumen);
      listDataKonsumen.forEach((e) => listShowAction.add(false));
      listDataKonsumen.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }
    notifyListeners();
  }

  // Non Activate & Activate Consumen
  nonActiveKonsumen(DataConsumer data) async {
    progressDialog(context);
    var res = await konsumenRepo.activateNonActivateCons(data);
    Navigator.pop(context);
    if (res is! String) {
      init();
    } else {
      showLocalSnackbar(res, key);
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

  void reset() {
    listShowAction.clear();
    listDataKonsumen.clear();
    listBackup.clear();
    notifyListeners();
  }
}
