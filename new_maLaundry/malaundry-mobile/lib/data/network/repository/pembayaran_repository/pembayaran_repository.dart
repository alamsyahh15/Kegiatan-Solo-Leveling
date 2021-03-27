import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/model/pembayaran_model/detail_pembayaran_model.dart';
import 'package:ma_laundry/data/model/pembayaran_model/pembayaran_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class PembayaranRepository {
  /// API Detail Pembayaran
  Future getDetailPembayaran(DataOrder data) async {
    try {
      Response res = await dio.get(
        DETAIL_PEMBAYARAN_URL + "${data.idTransaksi}",
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return DetailPembayaranModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Approve Reject
  Future approveRejectPembayaran(
      PembayaranData data, String statusAction, String note) async {
    try {
      Response res = await dio.post(
        APPROVAL_PEMBAYARAN_URL + "${data.pembayaran.idPembayaran}",
        data: FormData.fromMap({'status': "$statusAction", 'note': "$note"}),
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return res.data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Pembayaran
  Future getDataPembayaran(
      {DateTime dateFrom,
      DateTime dateTo,
      String filterBy = "Today",
      String statusBy}) async {
    Map<String, dynamic> query = {};
    query['metode_pembayaran'] = 'TRANSFER';
    query['type'] = 'pembayaran';
    query['filter'] = filterBy;
    if (dateTo != null) {
      query['date_to'] = formatDate(dateTo);
    }
    if (dateFrom != null) {
      query['date_from'] = formatDate(dateFrom);
    }
    if (statusBy != null) {
      query['status_persetujuan'] = statusBy;
    }
    try {
      Response res = await dio.get(
        DATA_LAUNDRY_URL,
        queryParameters: query,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return PembayaranModel.fromJson(res.data).data;
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

final pembayaranRepo = PembayaranRepository();
