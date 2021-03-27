import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/intl_tools.dart';

class OrderRepository {
  /// API GET Detail Order Laundry
  Future getDetailLaundry(DataOrder data) async {
    try {
      Response res = await dio.get(DATA_LAUNDRY_URL,
          queryParameters: {
            'id': "${data.idTransaksi}",
            'type': 'detail_order',
          },
          options: Options(headers: apiHeader.headers));
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

  /// API SET COMPLETE LAUNDRY
  Future setCompleteLaundry(DataOrder data) async {
    try {
      Response res = await dio.get(
          SET_COMPLETE_LAUNDRY_URL + "${data?.idTransaksi}/COMPLETED",
          options: Options(headers: apiHeader.headers));
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

  /// API SET Canceled LAUNDRY
  Future setCanceledLaundry(DataOrder data, String note) async {
    try {
      Response res = await dio.post(
          SET_CANCEL_LAUNDRY_URL + "${data?.idTransaksi}",
          data: FormData.fromMap(
              {'catatan_cancel': note ?? "Cancel Order ya Pak/Bu"}),
          options: Options(headers: apiHeader.headers));
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

  /// API GET Order Data
  Future getDataOrder(
      {DateTime dateFrom,
      DateTime dateTo,
      String filterBy = "Today",
      String statusBy}) async {
    Map<String, dynamic> query = {};
    query['status_pengambilan'] = "BELUM";
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
}

final orderRepo = OrderRepository();
