import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/data_transaction_model/create_paket_model.dart';
import 'package:ma_laundry/data/model/data_transaction_model/paket_kuota_model.dart';
import 'package:ma_laundry/data/model/kas_laundry_model/data_transaction_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class DataTransactionRepository {
  /// API Create Paket Kuota
  Future createPaketKuota(DataPaket data) async {
    try {
      Response res = await dio.post(
        CREATE_PAKET_KUOTA_URL,
        data: FormData.fromMap(data.toJson()),
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return CreatePaketModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Paket Kuota
  Future getPaketKuota() async {
    try {
      Response res = await dio.get(
        PAKET_KUOTA_URL,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return PaketKuotaModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Tansaksi Paket
  Future getDataTransactionPaket({
    String filter = "Today",
    DateTime dateFrom,
    DateTime dateTo,
  }) async {
    Map<String, dynamic> query = {};
    query['filter'] = filter;
    if (dateFrom != null) {
      query['date_from'] = formatDate(dateFrom);
    }
    if (dateTo != null) {
      query['date_to'] = formatDate(dateTo);
    }

    try {
      Response res = await dio.get(
        DATA_TRANSACTION_URL,
        queryParameters: query,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return DataTransactionModel.fromJson(res.data).data;
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

final dataTransactionRepo = DataTransactionRepository();
