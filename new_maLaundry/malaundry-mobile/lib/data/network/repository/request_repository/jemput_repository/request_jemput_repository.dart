import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/request_model/kurir_model.dart';
import 'package:ma_laundry/data/model/request_model/request_jemput_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class RequestJemputRepository {
  /// API Update Req Jemput
  Future setKurir(DataJemput dataJemput) async {
    try {
      Response res =
          await dio.post(UPDATE_REQ_JEMPUT_URL + "${dataJemput.idJemput}",
              data: FormData.fromMap({
                'id_kurir': "${dataJemput.idKurir}",
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

  /// API GET Data Kurir
  Future getKurir() async {
    try {
      Response res = await dio.get(DATA_USER_URL,
          queryParameters: {
            'is_active': "ALL",
            'level[]': "KURIR",
            'id_cabang': "${accountData.account.idCabang}"
          },
          options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return KurirModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API GET Data Request Jemput
  Future getRequestJemput({
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
      Response res = await dio.get(REQUEST_JEMPUT_URL,
          queryParameters: query, options: Options(headers: apiHeader.headers));
      if (res.statusCode == 200) {
        return RequestJemputModel.fromJson(res.data).data;
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

final requestJemputRepo = RequestJemputRepository();
