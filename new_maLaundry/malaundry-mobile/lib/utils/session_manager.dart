import 'dart:convert';
import 'dart:developer';
import 'package:ma_laundry/data/local/account_data.dart';
import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
import 'package:ma_laundry/data/network/network_export.dart';
import 'package:ma_laundry/ui/main/account_screen/login_page.dart';
import 'package:ma_laundry/ui/main/home_screen/home_page.dart';
import 'package:ma_laundry/utils/navigator_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> pref = SharedPreferences.getInstance();

class SessionManager {
  Future checkSession(context) async {
    var check = await pref;
    var user = await check.get("user");
    var token = await check.get("accessToken");
    apiHeader?.token = token;
    try {
      if (user != null && token != null) {
        log("Headers : ${apiHeader?.headers}");
        log("User ${accountData?.account}");
        accountData?.account = User?.fromJson(jsonDecode(user));
        if (user != null && token != null) {
          navigateRemoveUntil(context, HomePage());
        }
      } else {
        navigateRemoveUntil(context, LoginPage());
      }
    } catch (e) {
      navigateRemoveUntil(context, LoginPage());
    }
  }

  Future clearSession(context) async {
    var session = await pref;
    session.clear();
    // ignore: deprecated_member_use
    session.commit();
    navigateRemoveUntil(context, LoginPage());
  }
}

final sessionManager = SessionManager();
