import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/request_model/request_antar_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class RequestAntarRepository {
  /// API UPDATE ANTAR
  Future setKurirAntar(AntarData data) async {
    try {
      Response res = await dio.post(UPDATE_REQ_ANTAR_URL + "${data?.idAntar}",
          data: FormData.fromMap({
            'id_kurir': '${data?.idKurir}',
          }),
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

  /// API GET ANTAR DATA
  Future getAntarData({
    DateTime dateFrom,
    DateTime dateTo,
    String filterBy = "Today",
    String statusBy,
    String idKonsumen,
    String idKurir,
  }) async {
    Map<String, dynamic> query = {};
    query['filter'] = filterBy;
    if (idKonsumen != null) {
      query['id_konsumen'] = idKonsumen;
    }
    if (idKurir != null) {
      query['id_kurir'] = idKurir;
    }
    if (dateTo != null) {
      query['date_to'] = formatDate(dateTo);
    }
    if (dateFrom != null) {
      query['date_from'] = formatDate(dateFrom);
    }
    if (statusBy != null) {
      query['status'] = statusBy;
    }
    try {
      Response res = await dio.get(REQUEST_ANTAR_URL,
          queryParameters: query, options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return RequestAntarModel.fromJson(res.data).data;
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

final requestAntarRepo = RequestAntarRepository();
