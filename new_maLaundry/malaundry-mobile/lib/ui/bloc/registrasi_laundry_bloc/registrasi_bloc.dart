import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/create_landry_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/parfume_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_kiloan_model.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/service_satuan_model.dart';
import 'package:ma_laundry/data/network/repository/export_repo.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/home_screen/home_page.dart';

class RegistrasiBloc extends ChangeNotifier {
  /// ==== Constructor ====
  RegistrasiBloc(this.context, {this.key}) {
    this.init();
  }
  RegistrasiBloc.addConsumer(this.context, {this.key});

  /// ==== Initial ====
  void init() async {
    isLoading = true;
    await getSearchConsumer();
    isLoading = false;
  }

  void initService() async {
    progressDialog(context);
    await reset();
    await getServiceKilos();
    await getServiceUnit();
    await getParfume();
    Navigator.pop(context);
  }

  /// ==== Property ====
  List<double> listPriceKiloan = [];
  List<double> listPriceSatuan = [];
  List<DataConsumer> listConsumer = [];
  List<DataSatuan> listUnit = [], listBackupUnit = [], listInputUnit = [];
  List<DataKiloan> listKilos = [], listBackupKilos = [], listInputKilos = [];
  List<bool> listShowItemKilos = [],
      listCheckItemKilos = [],
      listShowItemUnit = [],
      listCheckItemUnit = [];
  List<DataParfume> listParfume = [];
  DataParfume valParfume;
  DataConsumer valDataConsumer = DataConsumer();
  BuildContext context;
  GlobalKey<ScaffoldState> key;
  File _photoAddtional;
  bool _lunturVal = false, _tasKantongVal = false;
  String _noteVal;
  String _paymentMethodVal, _billingStatusVal;
  String _sisaTagihan,
      _diskon,
      _kembalian,
      _jumlahPembayaran,
      _totalTagihan,
      _backupTagihan;
  String washingQuotaUsed = "0", setrikaQuotaUsed = "0";
  bool _isLoading = false;

  /// Getter Setter
  String get jumlahPembayaran => _jumlahPembayaran;
  set jumlahPembayaran(String val) {
    _jumlahPembayaran = val;
    notifyListeners();
  }

  String get diskon => _diskon;
  set diskon(String val) {
    _diskon = val;
    notifyListeners();
  }

  String get backupTagihan => _backupTagihan;
  set backupTagihan(String val) {
    _backupTagihan = val;
    notifyListeners();
  }

  String get kembalian => _kembalian;
  set kembalian(String val) {
    _kembalian = val;
    notifyListeners();
  }

  String get sisaTagihan => _sisaTagihan;
  set sisaTagihan(String val) {
    _sisaTagihan = val;
    notifyListeners();
  }

  String get totalTagihan => _totalTagihan;
  set totalTagihan(String val) {
    _totalTagihan = val;
    notifyListeners();
  }

  String get noteVal => _noteVal;
  set noteVal(String val) {
    _noteVal = val;
    notifyListeners();
  }

  String get paymentMethodVal => _paymentMethodVal;
  set paymentMethodVal(String val) {
    _paymentMethodVal = val;
    notifyListeners();
  }

  String get billingStatusVal => _billingStatusVal;
  set billingStatusVal(String val) {
    _billingStatusVal = val;
    notifyListeners();
  }

  bool get lunturVal => _lunturVal;
  set lunturVal(bool val) {
    _lunturVal = val;
    notifyListeners();
  }

  bool get tasKantongVal => _tasKantongVal;
  set tasKantongVal(bool val) {
    _tasKantongVal = val;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  File get photoAdditional => _photoAddtional;
  set photoAdditional(File val) {
    _photoAddtional = val;
    notifyListeners();
  }

  /// ==== Method ====

  // Count Sisa Tagihan
  void countSisaTagihan() {
    double totalHarga = 0;
    diskon = "0";

    listInputKilos?.forEach((e) {
      totalHarga += double.parse(e.harga);
    });
    listInputUnit.forEach((e) {
      totalHarga += double.parse(e.harga);
    });

    log("Harga Total $totalHarga");

    totalTagihan = "${(totalHarga.round())}";
    String tempTotal = "${totalHarga.round()}";
    if (tempTotal.length > 3) {
      diskon = tempTotal.substring(tempTotal.length - 3);
      log("Diskon1 $diskon");
      if (double.parse(diskon) > 500) {
        diskon = "${double.parse(diskon) - 500}";
      }
      if (double.parse(diskon) == 500) {
        diskon = '0';
      }
      log("Diskon2 $diskon");
    }

    backupTagihan = "${(totalHarga - double.parse(diskon)).round()}";
    sisaTagihan =
        "${((totalHarga - double.parse(diskon ?? "0")).round()) - double.parse(jumlahPembayaran ?? "0").round()}";
    if (double.parse(sisaTagihan) < 0) {
      sisaTagihan = "0";
    }
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

  // Get Service Kilos
  Future getServiceKilos() async {
    var res = await registrasiFormRepo.getServiceKilos();
    var res2 = await registrasiFormRepo.getServiceKilos();
    if (res2 is ServiceKiloanModel) {
      listBackupKilos.addAll(res2.data);
      notifyListeners();
    }
    if (res is! String) {
      if (res?.data != null) {
        listKilos = res.data;
        listKilos.forEach((e) {
          listShowItemKilos.add(false);
          listCheckItemKilos.add(false);
          listPriceKiloan.add(double.parse(e.harga));
        });
      }
      notifyListeners();
    } else {
      showLocalSnackbar(res, key);
    }
  }

  // Get Service Unit
  Future getServiceUnit() async {
    var res = await registrasiFormRepo.getServiceSatuan();
    var res2 = await registrasiFormRepo.getServiceSatuan();
    if (res2 is ServiceSatuanModel) {
      listBackupUnit.addAll(res2.data);
      notifyListeners();
    }
    if (res is! String) {
      if (res?.data != null) {
        listUnit.addAll(res.data);
        listUnit.forEach((e) {
          listShowItemUnit.add(false);
          listCheckItemUnit.add(false);
          listPriceSatuan.add(double.parse(e.harga));
        });
      }
      notifyListeners();
    } else {
      showLocalSnackbar(res, key);
    }
  }

  // Get Parfume Data
  Future getParfume() async {
    var res = await registrasiFormRepo.getParfume();

    if (res is! String) {
      if ((res?.data?.length ?? 0) > 0) {
        listParfume = res.data;
      }
      notifyListeners();
    } else {
      showLocalSnackbar(res, key);
    }
  }

  // Vlidation Submit
  bool validation() {
    bool valid = true;
    if ((listInputKilos?.length ?? 0) == 0 ||
        (listCheckItemUnit?.length ?? 0) == 0) {
      valid = false;
    } else {
      valid = true;
    }
    if (valParfume == null) {
      valid = false;
    }
    if (valDataConsumer?.username == null) {
      valid = false;
    }

    if (billingStatusVal == null) {
      valid = false;
    }

    if (paymentMethodVal == null) {
      valid = false;
    }
    log('$valid');
    return valid;
  }

  // Create Order Laundry
  Future<DataOrder> createLaundry(RegistrasiBloc bloc) async {
    progressDialog(context);
    DataOrder orderDetail;
    var res = await registrasiFormRepo.createOrderLaundry(bloc);
    Navigator.pop(context);
    if (res is! String) {
      Data data1 = res;
      await customConfirmDialog(
        context,
        content: "Apakah kamu ingin mencetak struk ini ?",
        noButton: () async {
          log("Print This ");
          Navigator.pop(context);
          Navigator.pop(context);
          mainPageController.index = 2;
          notifyListeners();
        },
        yesButton: () async {
          progressDialog(context);
          DataOrder dataInput = DataOrder(idTransaksi: data1.idTransaksi);
          var tempDataOrder = await orderRepo.getDetailLaundry(dataInput);
          Navigator.pop(context);
          Navigator.pop(context);
          if (tempDataOrder is! String) {
            List<DataOrder> dataOrder = tempDataOrder;
            if ((dataOrder?.length ?? 0) > 0) {
              orderDetail = dataOrder[0];
            }
          }
        },
      );
    } else {
      showLocalSnackbar("e", key);
    }
    return orderDetail;
  }

  // Reset All Value
  Future reset() async {
    listPriceKiloan = [];
    listPriceSatuan = [];
    listUnit = [];
    listBackupUnit = [];
    listInputUnit = [];
    listKilos = [];
    listBackupKilos = [];
    listInputKilos = [];
    listShowItemKilos = [];
    listCheckItemKilos = [];
    listShowItemUnit = [];
    listCheckItemUnit = [];
    listParfume = [];
    valParfume = null;
    photoAdditional = null;
    _lunturVal = false;
    _tasKantongVal = false;
    _noteVal = null;
    _paymentMethodVal = null;
    _billingStatusVal = null;
    _sisaTagihan = null;
    _diskon = null;
    _kembalian = null;
    _jumlahPembayaran = null;
    _totalTagihan = null;
    _backupTagihan = null;
    washingQuotaUsed = "0";
    setrikaQuotaUsed = "0";
    notifyListeners();
  }

  resetData() {
    _sisaTagihan = null;
    _diskon = null;
    _kembalian = null;
    _jumlahPembayaran = null;
    _totalTagihan = null;
    _backupTagihan = null;
    valParfume = null;
    washingQuotaUsed = "0";
    setrikaQuotaUsed = "0";
    listInputKilos = [];
    listInputUnit = [];
    _lunturVal = false;
    _tasKantongVal = false;
    listShowItemKilos = [];
    listCheckItemKilos = [];
    listShowItemUnit = [];
    listCheckItemUnit = [];
    listKilos.forEach((element) {
      listShowItemKilos.add(false);
      listCheckItemKilos.add(false);
    });
    listUnit.forEach((element) {
      listShowItemUnit.add(false);
      listCheckItemUnit.add(false);
    });
    notifyListeners();
  }
}
