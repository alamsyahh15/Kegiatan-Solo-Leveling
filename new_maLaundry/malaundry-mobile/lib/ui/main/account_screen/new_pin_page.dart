import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/account_model.dart/user_model.dart';
import 'package:ma_laundry/data/network/repository/reset_pin_repository/reset_pin_repository.dart';
import 'package:ma_laundry/ui/config/export_config.dart';

class NewPinPage extends StatefulWidget {
  final UserData user;

  const NewPinPage({Key key, this.user}) : super(key: key);
  @override
  _NewPinPageState createState() => _NewPinPageState();
}

class _NewPinPageState extends State<NewPinPage> {
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
  bool _obSecure = true;
  bool get obSecure => _obSecure;
  set obSecure(bool val) {
    setState(() {
      _obSecure = val;
    });
  }

  String newPin = "", confirmPin = "";
  bool validConfirm() {
    return confirmPin.isNotEmpty && confirmPin == newPin;
  }

  @override
  Widget build(BuildContext context) {
    log("Id ${widget.user.id} ${validConfirm()}");
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
                width: widthScreen(context),
                margin: EdgeInsets.symmetric(
                    vertical: medium + medium, horizontal: medium),
                child: Column(
                  children: [
                    Text(
                      "Buat PIN Baru",
                      style: sansPro(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: medium + medium),
                    CustomTextField(
                      keyboardType: TextInputType.number,
                      label: "PIN Baru",
                      obscureText: obSecure,
                      suffixIcon: IconButton(
                        icon: Icon(
                          obSecure ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          obSecure = !obSecure;
                        },
                      ),
                      onChanged: (val) {
                        setState(() {
                          newPin = val;
                        });
                      },
                    ),
                    SizedBox(height: medium),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Konfirmasi PIN",
                                  style: sansPro(fontWeight: FontWeight.w600)),
                              Visibility(
                                visible: validConfirm() ? false : true,
                                child: Text("PIN Tidak Sama",
                                    style: sansPro(
                                        color: Colors.red, fontSize: 11)),
                              ),
                            ],
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: medium, right: normal),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color:
                                      validConfirm() ? greyColor : Colors.red,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(normal))),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onChanged: (val) {
                                setState(() {
                                  confirmPin = val;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: medium),
                    CustomRaisedButton(
                      title: "Simpan",
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (validConfirm()) {
                          progressDialog(context);
                          var res = await resetPinRepo.resetPin(
                              confirmPin, widget.user);
                          Navigator.pop(context);
                          if (res is! String) {
                            Navigator.pop(context);
                          } else {
                            showLocalSnackbar(res, key);
                          }
                        } else {
                          showLocalSnackbar("Pastikan PIN benar", key);
                        }
                      },
                    )
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
