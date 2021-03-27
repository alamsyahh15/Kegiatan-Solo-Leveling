import 'package:dio/dio.dart';
import 'package:mentoringmasalam2/models/user_model.dart';

Dio dio = Dio();
final String baseUrl = "http://192.168.20.37/server_udacoding_CI/Api/";

class UserRepository {
  // menyimpan function-funnction transaksi data yag berhubungan dengan user
  Future getDataUser() async {
    //tidak tahu berapa lama ambil di server (async)
    Response res = await dio.get(baseUrl + "getData");

    if (res.statusCode == 200) {
      return userModelFromJson(res.data).user;
    }
  }

  Future getDataUserByAge(int age) async {
    Response res = await dio.get(baseUrl + 'getDataUserByAge?age=$age');

    if (res.statusCode == 200) {
      return userModelFromJson(res.data).user;
    }
  }
}

final userRepo = UserRepository(); //supaya bisa di panggil ke home_page.dart
