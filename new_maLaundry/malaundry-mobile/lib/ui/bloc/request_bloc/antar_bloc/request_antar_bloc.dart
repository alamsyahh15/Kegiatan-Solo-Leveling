import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/request_model/request_antar_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/data/network/repository/request_repository/antar_repository/request_antar_repository.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:ma_laundry/ui/main/order_screen/detail_order_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class RequestAntarBloc extends ChangeNotifier {
  /// Constructor
  RequestAntarBloc(this.context, {this.key}) {
    this.init();
  }

  /// Initial
  void init() async {
    isLoading = true;
    await getAntarData();
    isLoading = false;
  }

  /// Property
  List<AntarData> listAntarData = [], backupListAntarData = [];
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

  /// Method

  // Set Kurir
  Future setKurir(AntarData data) async {
    progressDialog(context);
    var res = await requestAntarRepo.setKurirAntar(data);
    Navigator.pop(context);
    Navigator.pop(context);
    if (res is! String) {
      showLocalSnackbar("${res['message']}", key);
    } else {
      showLocalSnackbar(res, key);
    }
    init();
  }

  // GET Antar Data
  Future getAntarData() async {
    try {
      reset();
      var res = await requestAntarRepo.getAntarData();
      if (res is! String) {
        listAntarData = res;
        backupListAntarData.addAll(listAntarData);
        listAntarData.forEach((element) {
          listShowAction.add(false);
        });
      } else {
        showLocalSnackbar('$res', key);
      }
      notifyListeners();
    } catch (e) {}
  }

  /// Get Detail
  Future getDetailData(int idTransaksi) async {
    DataOrder dataOrder = DataOrder(idTransaksi: idTransaksi);
    DataOrder data;
    progressDialog(context);
    var res = await orderRepo.getDetailLaundry(dataOrder);
    Navigator.pop(context);
    if (res != null) {
      data = res[0];
      navigateTo(context, DetailOrderPage(data: data)).then((value) {
        init();
      });
    }
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
    reset();
    notifyListeners();
    var res = await requestAntarRepo.getAntarData(
        dateTo: dateTo,
        dateFrom: dateFrom,
        filterBy: filterBy,
        idKonsumen: idKonsumen,
        statusBy: statusBy,
        idKurir: idKurir);
    isLoading = false;
    if (res is! String) {
      listAntarData = res;
      backupListAntarData.addAll(listAntarData);
      listAntarData.forEach((element) {
        listShowAction.add(false);
      });
    }
    notifyListeners();
  }

  // Search Data
  void search(String query) {
    listAntarData = backupListAntarData;
    if (query != null || query.isNotEmpty) {
      query = query.toLowerCase();
      listAntarData = listAntarData
          .where((e) =>
              e.kode.toLowerCase().contains(query) ||
              e.namaKonsumen.toLowerCase().contains(query) ||
              e.namaKurir.toLowerCase().contains(query))
          .toList();
      listShowAction.clear();
      listAntarData.forEach((element) {
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

  // Reset Data
  void reset() {
    listAntarData.clear();
    backupListAntarData.clear();
    listShowAction.clear();
    notifyListeners();
  }
}
