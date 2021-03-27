import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';

class AccountData {
  static final _accountData = AccountData._();
  User _account;
  AccountData._();
  factory AccountData() => _accountData;

  // ignore: unnecessary_getters_setters
  User get account => _account;

  // ignore: unnecessary_getters_setters
  set account(User user) {
    _account = user;
  }
}

AccountData accountData = AccountData();
