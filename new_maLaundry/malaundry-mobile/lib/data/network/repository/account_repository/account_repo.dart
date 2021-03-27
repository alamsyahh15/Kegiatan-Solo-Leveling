import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
import '../../network_export.dart';

class AccountRepository {
  /// API Login User
  Future loginUser(User user) async {
    try {
      Response res = await dio.post(
        LOGIN_URL,
        data: FormData.fromMap(user.toJson()),
      );
      if (res.statusCode == 200) {
        return AccountModel.fromJson(res?.data);
      }
    } on DioError catch (e, st) {
      log("Exception $e");
      return DioHandler.parseDioErrorMessage(e, st);
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API SET Firebase Token
  Future setFirebaseToken(User user) async {
    try {
      Response res =
          await dio.post(SET_FIREBASE_URL + "${accountData.account.id}",
              data: FormData.fromMap({
                'firebase_token': user.firebaseToken,
              }),
              options: Options(headers: apiHeader.headers));
      log("${res.data}");
      if (res.statusCode == 200) {
        return AccountModel.fromJson(res?.data);
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

final accountRepo = AccountRepository();
