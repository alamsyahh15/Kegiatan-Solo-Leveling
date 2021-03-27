import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/data/network/repository/account_repository/account_repo.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/home_screen/home_page.dart';
import 'package:ma_laundry/utils/navigator_helper.dart';
import 'package:ma_laundry/utils/session_manager.dart';

class LoginBloc extends ChangeNotifier {
  LoginBloc(this.context, {this.scaffoldKey});

  /// Property
  bool _isLoading = false;
  BuildContext context;
  GlobalKey<ScaffoldState> scaffoldKey;

  bool get isLoading => _isLoading;
  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  /// State
  Future loginUser(User user) async {
    FocusScope.of(context).unfocus();
    isLoading = true;
    AccountModel res = await accountRepo.loginUser(user);
    if (res is! String) {
      if (res.status == true) {
        if (res.user.level == "ADMIN") {
          await saveSession(res);
        } else {
          showLocalSnackbar("Akun anda tidak punya akses!!", scaffoldKey);
        }
      } else {
        showLocalSnackbar(res.message, scaffoldKey);
      }
    } else {
      showLocalSnackbar(res, scaffoldKey);
    }

    isLoading = false;
  }

  Future saveSession(AccountModel res) async {
    var save = await pref;
    await save.setString("user", jsonEncode(res?.user?.toJson()));
    await save.setString("accessToken", res.token);
    apiHeader.token = res.token;
    FirebaseMessaging firebaseMessaging = FirebaseMessaging();
    var tokenMessaging = await firebaseMessaging.getToken();
    accountData.account = res.user;
    accountData.account.firebaseToken = tokenMessaging;
    await accountRepo.setFirebaseToken(res.user);
    if (res?.user != null) {
      navigateRemoveUntil(context, HomePage());
    }
  }
}
