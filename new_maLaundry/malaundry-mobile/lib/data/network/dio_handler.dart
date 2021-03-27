import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHandler {
  static BuildContext context;

  static void setContext(BuildContext context) {
    DioHandler.context = context;
  }

  static String parseDioErrorMessage(DioError e, StackTrace st) {
    String error;
    switch (e.type) {
      case DioErrorType.CONNECT_TIMEOUT:
        error = "Connection Time Out";
        break;
      case DioErrorType.SEND_TIMEOUT:
        error = "Connection Send Time Out";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        error = "Connection Receive Time Out";
        break;
      case DioErrorType.RESPONSE:
        error = "Error Status Code ${e.response.statusCode}";
        break;
      case DioErrorType.CANCEL:
        error = "Error Status Cancel";
        break;
      case DioErrorType.DEFAULT:
        error = "Error Connection no Internet";
        break;
    }

    return error;
  }
}
