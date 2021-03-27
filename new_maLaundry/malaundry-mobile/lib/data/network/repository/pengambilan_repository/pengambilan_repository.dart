import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/pengambilan_model.dart/take_order_model.dart';

import '../../../../utils/export_utils.dart';
import '../../network_export.dart';

class PengambilanRepository {
  /// API Ambil Order
  Future ambilOrder(DataOrder data) async {
    log("Data ${data.toJson()}");
    try {
      Response res = await dio.post(AMBIL_LAUNDRY_URL + "${data?.idTransaksi}",
          data: FormData.fromMap(data?.toJson()),
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        if (TakeOrderModel.fromJson(res.data).status == false) {
          return TakeOrderModel.fromJson(res.data)?.message;
        } else {
          return TakeOrderModel.fromJson(res.data)?.data;
        }
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Order Data
  Future getDataPengambilan(
      {DateTime dateFrom,
      DateTime dateTo,
      String filterBy = "Today",
      String statusBy}) async {
    Map<String, dynamic> query = {};
    query['status_pengambilan'] = "SUDAH";
    if (dateTo != null) {
      query['date_to'] = formatDate(dateTo);
    }
    if (dateFrom != null) {
      query['date_from'] = formatDate(dateFrom);
    }
    if (filterBy != null) {
      query['filter'] = filterBy;
    }
    if (statusBy != null) {
      query['status_laundry'] = statusBy;
    }

    try {
      Response res = await dio.get(DATA_LAUNDRY_URL,
          queryParameters: query, options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return DataOrderModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Check Nomor Laundry
  Future checkNomorLaundry(String kodeTransaction) async {
    Map<String, dynamic> query = {};
    query['kode_transaksi'] = kodeTransaction;
    query['type'] = 'cek_nomor';
    try {
      Response res = await dio.get(DATA_LAUNDRY_URL,
          queryParameters: query, options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return DataOrderModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }
}

final pengambilanRepo = PengambilanRepository();
