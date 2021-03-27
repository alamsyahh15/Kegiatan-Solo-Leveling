import 'package:dio/dio.dart';

Dio dio = Dio();

class ApiHeader {
  static final _apiHeader = ApiHeader._();
  var _headers = {'Accept': 'application/json'};

  ApiHeader._();
  factory ApiHeader() => _apiHeader;

  Map<String, String> get headers => _headers;

  set token(String token) {
    _headers['Authorization'] = 'Bearer $token';
  }

  void removeToken() {
    _headers.remove('Authorization');
  }

  void applyHeader(String name, String value) {
    _headers[name] = value;
  }
}

ApiHeader apiHeader = ApiHeader();
