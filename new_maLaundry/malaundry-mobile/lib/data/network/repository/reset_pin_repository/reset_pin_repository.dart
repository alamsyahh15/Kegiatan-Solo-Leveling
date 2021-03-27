import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ma_laundry/data/model/account_model.dart/user_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';

class ResetPinRepository {
  Future getUserByPhone(String numPhone) async {
    if (numPhone.isNotEmpty && numPhone != null) {
      numPhone = numPhone.replaceAll("+", "");
    }
    try {
      Response res =
          await dio.get(CHECK_USER, queryParameters: {'telp': numPhone});
      if (res.statusCode == 200) {
        return UserModel.fromJson(res.data).data;
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  Future resetPin(String pin, UserData data) async {
    try {
      Response res =
          await dio.post(RESET_PIN + "${data.id}", data: {'pin': '$pin'});
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

final resetPinRepo = ResetPinRepository();
