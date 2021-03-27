import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/create_pengeluaran_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/item_model.dart';
import 'package:ma_laundry/data/model/pengeluaran_model/pengeluaran_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import '../../api_endpoint.dart';
import '../../network_export.dart';

class PengeluaranRepository {
  /// API GET Pengeluaran
  Future getPengeluaran(
      {DateTime dateFrom, DateTime dateTo, String filterBy = "Today"}) async {
    Map<String, dynamic> query = {};
    if (filterBy != null) {
      query['filter'] = filterBy;
    }
    if (dateFrom != null) {
      query['date_from'] = formatDate(dateFrom);
    }
    if (dateTo != null) {
      query['date_to'] = formatDate(dateTo);
    }

    try {
      Response res = await dio.get(DATA_PENGELUARAN_URL,
          queryParameters: query, options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return PengeluaranModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API CREATE Pengeluaran
  Future createPengeluaran(DataPengeluaran data) async {
    try {
      Response res = await dio.post(
        CREATE_PENGELUARAN_URL,
        data: FormData.fromMap(data.toJson()),
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return CreatePengeluaranModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Item
  Future getItem() async {
    try {
      Response res = await dio.get(
        DATA_ITEM_URL,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return ItemModel.fromJson(res.data).data;
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

final pengeluaranRepo = PengeluaranRepository();
