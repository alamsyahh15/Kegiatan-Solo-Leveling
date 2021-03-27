import 'package:dio/dio.dart';
import 'package:simple_crud/model/user_model.dart';

/// ==== Class Repository ====
/// Digunakan untuk menyimpan function - function
/// transaksi data yang berhubungan dengan user

Dio dio = Dio();
final String baseUrl = "http://192.168.20.37/server_udacoding/Api/";

class UserRepository {
  /// Function get Data User
  Future getDataUser() async {
    Response res = await dio.get(baseUrl + "getData");

    if (res.statusCode == 200) {
      return userModelFromJson(res.data).user;
    }
  }
}

final userRepo = UserRepository();
