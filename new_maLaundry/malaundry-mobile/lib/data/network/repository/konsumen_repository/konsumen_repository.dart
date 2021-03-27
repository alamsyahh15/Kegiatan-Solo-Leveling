import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/laundry_form_model.dart/consumer_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class KonsumenRepository {
  Future activateNonActivateCons(DataConsumer data) async {
    try {
      Response res = await dio.post(
        KONSUMEN_URL + "is_active/${data?.idKonsumen}",
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

  /// API Konsumen
  Future getKonsumen({
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
    log("Url $KONSUMEN_URL");
    try {
      Response res = await dio.get(
        KONSUMEN_URL + "getData",
        queryParameters: query,
        options: Options(headers: apiHeader.headers),
      );
      if (res.statusCode == 200) {
        return ConsumerModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Update Konsumen
  Future updateKonsumen(DataConsumer data, {File image}) async {
    log("Url $KONSUMEN_URL" + "update/${data?.idKonsumen}");
    Map<String, dynamic> dataJson = {};
    dataJson['title'] = data.title;
    dataJson['nama_depan'] = data.namaDepan;
    dataJson['nama_belakang'] = data.namaBelakang;
    dataJson['username'] = data.username;
    dataJson['pin'] = data.kode;
    dataJson['telp'] = data.telp;
    dataJson['alamat'] = data.alamat;
    if (image != null) {
      dataJson['foto'] = await MultipartFile.fromFile(image.path);
    }

    try {
      Response res = await dio.post(
        KONSUMEN_URL + "update/${data?.idKonsumen}",
        data: FormData.fromMap(dataJson),
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
}

final konsumenRepo = KonsumenRepository();
