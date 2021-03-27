import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/total_kas_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:ma_laundry/data/network/api_header.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:ma_laundry/utils/intl_tools.dart';

class KasLaundryRepository {
  /// API GET LIST Kas
  Future getDataKas(String filter, String type) async {
    Future<Response> response() async {
      Response res;
      if (type == "LAUNDRY") {
        res = await dio.get(DATA_LAUNDRY_URL,
            queryParameters: {
              'type': "$type",
              'filter': filter ?? "Today",
              'date_from': formatDate(dateNow)
            },
            options: Options(headers: apiHeader.headers));
      } else if (type == "PENGELUARAN") {
        res = await dio.get(DATA_PENGELUARAN_URL,
            queryParameters: {
              'type': "$type",
              'filter': filter ?? "Today",
            },
            options: Options(headers: apiHeader.headers));
      } else {
        res = await dio.get(DATA_KAS_URL,
            queryParameters: {
              'type': "$type",
              'filter': filter ?? "Today",
              'date_from': formatDate(dateNow)
            },
            options: Options(headers: apiHeader.headers));
      }
      return res;
    }

    try {
      Response res = await response();
      if (res.statusCode == 200) {
        if (type == "LAUNDRY") {
          return DataOrderModel.fromJson(res.data).data;
        } else if (type == "PENGELUARAN") {
          return PengeluaranModel.fromJson(res.data).data;
        } else {
          return DataTransactionModel.fromJson(res.data).data;
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

  /// API GET TOTAL Kas
  Future getTotalKas(String filter) async {
    try {
      Response res = await dio.get(TOTAL_KAS_URL,
          queryParameters: {
            'type': "LAUNDRY",
            'filter': "$filter",
            'date_from': formatDate(dateNow)
          },
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return TotalKasModel.fromJson(res.data);
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

final kasLaundryRepo = KasLaundryRepository();
