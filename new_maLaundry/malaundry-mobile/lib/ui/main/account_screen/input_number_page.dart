import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/account_model.dart/user_model.dart';
import 'package:ma_laundry/data/network/repository/reset_pin_repository/reset_pin_repository.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:ma_laundry/ui/main/account_screen/otp_page.dart';
import 'package:ma_laundry/utils/export_utils.dart';

class InputNumberPage extends StatefulWidget {
  @override
  _InputNumberPageState createState() => _InputNumberPageState();
}

class _InputNumberPageState extends State<InputNumberPage> {
  String numberPhone = "";
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(medium),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(normal)),
              child: Container(
                margin: EdgeInsets.symmetric(
                    vertical: medium + medium, horizontal: medium),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Reset PIN",
                      style: sansPro(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: medium + medium + medium),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: medium,
                      ),
                      child: CustomTextField(
                        label: "Nomor Handphone",
                        showCodeDefaultNum: true,
                        keyboardType: TextInputType.number,
                        onChanged: (val) {
                          setState(() {
                            numberPhone = "+62$val";
                            log("Phone $numberPhone");
                          });
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: medium,
                        vertical: medium,
                      ),
                      child: CustomRaisedButton(
                        title: "Lanjut",
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          progressDialog(context);
                          List<UserData> listUser = [];
                          var res =
                              await resetPinRepo.getUserByPhone(numberPhone);
                          Navigator.pop(context);

                          if (res is! String) {
                            listUser = res;
                            if ((listUser?.length ?? 0) > 0) {
                              if (listUser[0].level.toUpperCase() != "ADMIN") {
                                showLocalSnackbar(
                                    "Data Dengan Nomor $numberPhone Tidak Ditemukan",
                                    key);
                              } else {
                                Navigator.pop(context);
                                navigateTo(
                                  context,
                                  OtpPhonePage(
                                    numberPhone: numberPhone,
                                    userData: listUser[0],
                                  ),
                                );
                              }
                            } else {
                              showLocalSnackbar(
                                  "Data Dengan Nomor $numberPhone Tidak Ditemukan",
                                  key);
                            }
                          } else {
                            showLocalSnackbar(res, key);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
