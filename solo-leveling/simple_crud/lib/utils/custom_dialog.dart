import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

progressDialog(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierColor: Colors.black45.withOpacity(0.65),
    barrierDismissible: false,
    pageBuilder: (context, animation1, animation2) =>
        Center(child: CircularProgressIndicator()),
  );
}
