import 'package:dio/dio.dart';
import 'package:simple_crud_with_mas_alam/model/user_model.dart';

Dio dio = Dio();
final String baseUrl = "http://192.168.20.37/server_udacoding/Api/";

class UserRepository {
  Future getDataUser() async {
    Response res = await dio.get(baseUrl + "getData");

    if (res.statusCode == 200) {
      return userModelFromJson(res.data).user;
    }
  }

  Future getDataUserByAge(int umur) async {
    Response res = await dio.get(baseUrl + "getDataByAge?umur=$umur");

    if (res.statusCode == 200) {
      return userModelFromJson(res.data).user;
    }
  }
}

final userRepository = UserRepository();
