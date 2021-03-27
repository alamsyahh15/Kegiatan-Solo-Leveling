import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/data/network/repository/pengambilan_repository/pengambilan_repository.dart';
import '../../../utils/export_utils.dart';
import '../../config/export_config.dart';
import '../../main/order_screen/detail_order_page.dart';

class PengambilanBloc extends ChangeNotifier {
  /// ==== Construtor ====
  PengambilanBloc(this.context, {this.key}) {
    this.init();
  }
  PengambilanBloc.takeOrder(this.context, {this.key});

  /// ==== Initial ====
  void init() async {
    try {
      isLoading = true;
      await getDataPengambilan();
      isLoading = false;
    } catch (e) {}
  }

  /// ==== Property ====
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  List<DataOrder> listDataPengambilan = [], backupListDataPengambilan = [];
  List<bool> listShowAction = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// ==== Method ====

  //  Ambil Laundry Order
  Future ambilLaundryOrder(DataOrder dataOrder) async {
    progressDialog(context);
    var res = await pengambilanRepo.ambilOrder(dataOrder);
    Navigator.pop(context);
    if (res is! String) {
      Navigator.pop(context);
    } else {
      showLocalSnackbar(res, key);
    }
  }

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

  // Get Data Pengambilan
  Future getDataPengambilan() async {
    try {
      var res = await pengambilanRepo.getDataPengambilan();
      if (res is String) {
        showLocalSnackbar(res, key);
      } else {
        listDataPengambilan = res;
        backupListDataPengambilan.addAll(listDataPengambilan);
        listDataPengambilan.forEach((element) {
          listShowAction.add(false);
        });
        notifyListeners();
      }
    } catch (e) {}
  }

  // Get Data Pengambilan
  Future checkNomorLaundry(String kodeTransaction) async {
    DataOrder data;
    FocusScope.of(context).unfocus();
    if (kodeTransaction?.isNotEmpty ?? kodeTransaction?.isNotEmpty != null) {
      kodeTransaction = kodeTransaction.toUpperCase();
      progressDialog(context);
      var res = await pengambilanRepo.checkNomorLaundry(kodeTransaction);
      if (res is String) {
        Navigator.pop(context);
        showLocalSnackbar(res, key);
      } else {
        List<DataOrder> tempList = res;
        log("Length ${tempList.length}");
        if ((tempList?.length ?? 0) > 0) {
          var resData = await orderRepo.getDetailLaundry(tempList[0]);
          Navigator.pop(context);
          if (tempList[0].statusLaundry == "COMPLETED" ||
              tempList[0].statusLaundry == "CANCELED") {
            if (resData is! String) {
              data = resData[0];
              navigateTo(context,
                      DetailOrderPage(data: data, fromPengambilan: true))
                  .then((value) {
                init();
              });
            }
          } else {
            showLocalSnackbar("Laundry Belum Selesai !!", key);
          }
        } else {
          Navigator.pop(context);
          showLocalSnackbar(
              "Data No: $kodeTransaction Tidak Ditemukan !!", key);
        }
      }
    } else {
      showLocalSnackbar("Harap Masukan Kode Transaksi !!", key);
    }
  }

  // Get Data Filter By
  Future getDataFilterBy(DateTime dateFrom, DateTime dateTo, String statusBy,
      String filterBy) async {
    isLoading = true;
    listDataPengambilan.clear();
    backupListDataPengambilan.clear();
    notifyListeners();
    var res = await pengambilanRepo.getDataPengambilan(
        dateTo: dateTo,
        dateFrom: dateFrom,
        statusBy: statusBy,
        filterBy: filterBy);
    isLoading = false;
    if (res is! String) {
      listDataPengambilan = res;
      backupListDataPengambilan.addAll(listDataPengambilan);
      listShowAction.clear();
      listDataPengambilan.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }

  // Search Data
  void search(String query) {
    listDataPengambilan = backupListDataPengambilan;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listDataPengambilan = listDataPengambilan
          .where((e) =>
              e.kodeTransaksi.toLowerCase().contains(query) ||
              e.konsumenFullName.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listDataPengambilan.forEach((element) {
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
}
