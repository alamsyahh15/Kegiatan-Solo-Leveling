import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_transaction_model/create_paket_model.dart';
import 'package:ma_laundry/data/model/data_transaction_model/paket_kuota_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/network/repository/data_transaction_repository/data_transaction_repository.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/ui/config/widget.dart';

class DataTransactionBloc extends ChangeNotifier {
  /// ==== Constructor ====
  DataTransactionBloc(this.context, {this.key}) {
    this.init();
  }
  DataTransactionBloc.initForm(this.context, {this.key}) {
    this.initForm();
  }

  /// ==== Initial ====
  void init() async {
    isLoading = true;
    await getTransaction();
    isLoading = false;
  }

  void initForm() async {
    isLoading = true;
    await getSearchConsumer();
    await getPaketKuota();
    isLoading = false;
  }

  /// ==== Property ====
  List<DataKuota> listKuota = [];
  List<DataConsumer> listConsumer = [];
  List<DataTransaction> listTransac = [], backupListTransc = [];
  List<bool> listShowAction = [];
  DataConsumer valDataConsumer;
  DataKuota valDataKuota;
  String valPayment;
  BuildContext context;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// ==== Method State ====
  // Create Paket
  Future createPaket(DataPaket data, TabController controller) async {
    progressDialog(context);
    var res = await dataTransactionRepo.createPaketKuota(data);

    Navigator.pop(context);
    if (res is! String) {
      controller.animateTo(0);
    } else {
      showLocalSnackbar(res, key);
    }
    notifyListeners();
  }

  // Get Data Customer
  Future getSearchConsumer() async {
    listConsumer.clear();
    var res = await registrasiFormRepo.searchDataConsumer();
    if (res is! String) {
      if (res?.data != null) {
        listConsumer = res.data;
      }
    } else {
      showLocalSnackbar(res, key);
    }
    notifyListeners();
  }

  // Get Paket Kuota
  Future getPaketKuota() async {
    var res = await dataTransactionRepo.getPaketKuota();
    if (res is String) {
      showLocalSnackbar(res, key);
    } else {
      listKuota = res;
    }
    notifyListeners();
  }

  // Get Data Transaction
  Future getTransaction() async {
    reset();
    var res = await dataTransactionRepo.getDataTransactionPaket();
    if (res is String) {
      showLocalSnackbar(res, key);
    } else {
      listTransac = res;
      backupListTransc.addAll(listTransac);
      listTransac.forEach((e) => listShowAction.add(false));
    }
    notifyListeners();
  }

  // Filter By
  Future filterDataBy(
      String filterBy, DateTime dateFrom, DateTime dateTo) async {
    isLoading = true;
    reset();
    var res = await dataTransactionRepo.getDataTransactionPaket(
      dateFrom: dateFrom,
      dateTo: dateTo,
      filter: filterBy,
    );
    isLoading = false;
    if (res is String) {
      showLocalSnackbar(res, key);
    } else {
      listTransac = res;
      backupListTransc.addAll(listTransac);
      listTransac.forEach((e) => listShowAction.add(false));
    }
    notifyListeners();
  }

  // searchData
  void search(String query) {
    listTransac = backupListTransc;
    listTransac = listTransac
        .where((e) =>
            e.kodeTransaksi.toLowerCase().contains(query) ||
            e.namaKonsumen.toLowerCase().contains(query))
        .toList();
    listShowAction.clear();
    listTransac.forEach((element) {
      listShowAction.add(false);
    });
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

  // Reset
  void reset() {
    listTransac.clear();
    backupListTransc.clear();
    listShowAction.clear();
    notifyListeners();
  }
}
