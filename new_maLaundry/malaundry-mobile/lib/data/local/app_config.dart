import 'package:ma_laundry/data/model/account_model.dart/app_config_model.dart';

class AppConfigData {
  static final _appConfigData = AppConfigData._();
  AppConfigModel _appConfig;
  AppConfigData._();
  factory AppConfigData() => _appConfigData;

  // ignore: unnecessary_getters_setters
  AppConfigModel get appConfig => _appConfig;

  // ignore: unnecessary_getters_setters
  set appConfig(AppConfigModel data) {
    _appConfig = data;
  }
}

AppConfigData appConfigData = AppConfigData();
