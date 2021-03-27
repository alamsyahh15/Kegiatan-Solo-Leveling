import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class RuleUtils {
  void savePreference(bool status, String token, String name, String email);
  Future getPreference();
  void clearSession(BuildContext context);
}

class SessionManager extends RuleUtils {
  String tokenUser, nameUser, emailUser;
  bool statusLogin;

  @override
  void savePreference(
      bool status, String token, String name, String email) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("status", status);
    sharedPreferences.setString("token", token);
    sharedPreferences.setString("name", name);
    sharedPreferences.setString("email", email);
    sharedPreferences.commit();
  }

  @override
  Future getPreference() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    statusLogin = sharedPreferences.getBool("status");
    tokenUser = sharedPreferences.getString("token");
    nameUser = sharedPreferences.getString("name");
    emailUser = sharedPreferences.getString("email");
    return statusLogin;
  }

  @override
  void clearSession(BuildContext context) async {
    // TODO: implement clearSession
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("status");
    sharedPreferences.remove("token");
    sharedPreferences.remove("name");
    sharedPreferences.remove("email");
    sharedPreferences.clear();
    sharedPreferences.commit();
  }
}

final SessionManager sessionManager = SessionManager();
