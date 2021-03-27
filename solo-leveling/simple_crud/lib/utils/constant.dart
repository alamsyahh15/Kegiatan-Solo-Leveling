import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String BASE_URL = "http://192.168.20.37/server_pegawai/";
Dio dio = Dio();
enum FETCH_STATE {STATE_LOADING,STATE_READY, STATE_ERROR}

Future goTo(BuildContext context,Widget widget)async{
  return Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

