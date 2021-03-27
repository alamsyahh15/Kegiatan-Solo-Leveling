import 'package:flutter/material.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/utils/connectivity_handler.dart';

Widget errorConnectWidget(BuildContext context) {
  return Visibility(
    visible: valueConnectivity == STATE_CONNECTIVITY.DISCONNECT,
    child: Container(
      color: Colors.red,
      width: widthScreen(context),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: small, bottom: small),
      margin: EdgeInsets.only(bottom: small),
      child: Text(
        "Tidak ada koneksi internet...",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
