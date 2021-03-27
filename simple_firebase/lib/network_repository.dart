import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:simple_firebase/post_model.dart';

class NetworkRepository {
  String baseUrl = "https://jsonplaceholder.typicode.com/";
  Dio dio = Dio();

  /// API Get Data
  Future<List<PostModel>> getData() async {
    try {
      Response res = await dio.get(baseUrl + "posts");
      if (res.statusCode == 200) {
        return postModelFromJson(res.data);
      }
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }

  /// API Get Detail
  Future<PostModel> getDetailData(int id) async {
    try {
      Response res = await dio.get(baseUrl + "posts/$id");
      if (res.statusCode == 200) {
        return PostModel.fromJson(res.data);
      }
    } catch (e) {
      log("Exception $e");
      return e;
    }
  }
}

final networkRepo = NetworkRepository();
