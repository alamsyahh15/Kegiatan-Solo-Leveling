import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:ma_laundry/data/model/data_order_model/data_order_model.dart';

Future<void> shareWhatsapp(DataOrder data, String nameFile) async {
  const platform = const MethodChannel('com.udacoding/whatsappShare');
  String numPhone = "";
  if (data?.konsumenNoHp != null && (data?.konsumenNoHp ?? "").isNotEmpty) {
    numPhone = data.konsumenNoHp;
    if (data.konsumenNoHp.contains("+")) {
      numPhone = data.konsumenNoHp.replaceFirst("+", "");
    }
  }
  log("NumPhone $numPhone");
  try {
    final result = await platform.invokeMethod(
        'sendWaWithFile', {"nameFile": "$nameFile", "numPhone": "$numPhone"});
    log("Res $result");
  } on PlatformException catch (e) {
    log("Res ${e.message}");
  }
}
