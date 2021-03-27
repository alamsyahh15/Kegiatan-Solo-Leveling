import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';

enum STATE_CONNECTIVITY { CONNECTED, DISCONNECT }
STATE_CONNECTIVITY valueConnectivity = STATE_CONNECTIVITY.CONNECTED;

class ConnecttivityHandler extends ChangeNotifier {
  bool active = true;
  Timer timer;
  ConnecttivityHandler() {
    this.init();
  }

  void init() {
    timer = Timer.periodic(Duration(seconds: 10), (timer) async {
      if (active) {
        await checkConnectivity();
      }
    });
  }

  Future checkConnectivity() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        valueConnectivity = STATE_CONNECTIVITY.CONNECTED;
      }
    } on SocketException catch (_) {
      print('not connected');
      valueConnectivity = STATE_CONNECTIVITY.DISCONNECT;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
}
