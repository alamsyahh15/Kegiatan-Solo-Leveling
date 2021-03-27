import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:simple_crud/model/model_pegawai.dart';
import 'package:simple_crud/utils/constant.dart';

class PegawaiRepository {
  /// Get Data Pegawai
  Future getPegawai() async {
    try {
      var result = await dio.get(BASE_URL + "getPegawai.php");
      print("Data Pegawai : ${jsonDecode(result.data)}");
      if (result.statusCode == 200) {
        return modelPegawaiFromMap(result.data);
      }
    } catch (e) {
      return null;
    }
  }

  /// Add Data Pegawai
  Future addPegawai(ModelPegawai data) async {
    try {
      var result = await dio.post(
        BASE_URL + "adddata.php",
        data: FormData.fromMap(data.toMap()),
      );
      print("Result ${result.data}");
      if (result.statusCode == 200) {
        return result.data;
      }
    } catch (e) {
      return null;
    }
  }

  /// Add Data Pegawai
  Future deletePegawai(ModelPegawai data) async {
    try {
      var result = await dio.post(
        BASE_URL + "deleteData.php",
        data: FormData.fromMap(data.toMap()),
      );
      print("Result ${result.data}");
      if (result.statusCode == 200) {
        return result.data;
      }
    } catch (e) {
      return null;
    }
  }

  /// Update Data Pegawai
  Future update(ModelPegawai data) async {
    try {
      var result = await dio.post(
        BASE_URL + "updatePegawai.php",
        data: FormData.fromMap(data.toMap()),
      );
      print("Result ${result.data}");
      if (result.statusCode == 200) {
        return result.data;
      }
    } catch (e) {
      return null;
    }
  }
}

final pegawaiRepo = PegawaiRepository();
