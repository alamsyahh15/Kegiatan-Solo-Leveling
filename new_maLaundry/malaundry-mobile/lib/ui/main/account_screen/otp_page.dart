import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:ma_laundry/data/model/account_model.dart/user_model.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/config/widget.dart';
import 'package:ma_laundry/ui/main/account_screen/new_pin_page.dart';
import 'package:ma_laundry/utils/navigator_helper.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

String manyRequest = "";

class OtpPhonePage extends StatefulWidget {
  final UserData userData;
  final String numberPhone;
  const OtpPhonePage({Key key, this.numberPhone, this.userData})
      : super(key: key);
  @override
  _OtpPhonePageState createState() => _OtpPhonePageState();
}

class _OtpPhonePageState extends State<OtpPhonePage> {
  TextEditingController codeController = TextEditingController();
  String verifId;
  GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();

  Future credetialAuth() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    await Firebase.initializeApp();

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: widget.numberPhone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential result = await auth.signInWithCredential(credential);
        final user = result.user;
        if (user != null) {
          log("User ${user.phoneNumber}");
        } else {
          print("Error");
        }
        log("Code sms: ${credential.smsCode}, Method :${credential.verificationId}");
        setState(() {
          codeController.text = credential.smsCode;
          // verifId = credential.verificationId;
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        setState(() {
          log("Exception ${e.code} ${e.phoneNumber} ${e.stackTrace}");
          if (e.code == "too-many-requests") {
            manyRequest = "too-many-requests";
          }
          showLocalSnackbar("${e.code}", key);
        });
      },
      codeSent: (String verificationId, int resendToken) {
        setState(() {
          verifId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  init() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      progressDialog(this.context);
      await Firebase.initializeApp();
      await credetialAuth();
      await Future.delayed(Duration(seconds: 4), () {
        Navigator.pop(this.context);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

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
                      "Verifikasi Kode",
                      style: sansPro(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: medium + medium),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: PinCodeTextField(
                        pinBoxHeight: 35,
                        pinBoxWidth: 35,
                        highlight: true,
                        highlightColor: Colors.blue,
                        defaultBorderColor: Colors.black,
                        hasTextBorderColor: Colors.green,
                        maxLength: 6,
                        isCupertino: true,
                        controller: codeController,
                      ),
                    ),
                    SizedBox(height: medium + medium),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: medium,
                        horizontal: medium + medium,
                      ),
                      child: CustomRaisedButton(
                        title: "Submit",
                        onPressed: () async {
                          progressDialog(context);
                          FirebaseAuth auth = FirebaseAuth.instance;
                          AuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verifId,
                                  smsCode: codeController.text);

                          try {
                            UserCredential result =
                                await auth.signInWithCredential(credential);
                            Navigator.pop(context);

                            final user = result.user;
                            if (user != null) {
                              Navigator.pop(context);
                              navigateTo(
                                  context, NewPinPage(user: widget.userData));
                            } else {
                              print("Error");
                              showLocalSnackbar("Error", key);
                            }
                          } catch (e) {
                            Navigator.pop(context);
                            showLocalSnackbar(e, key);
                          }
                        },
                      ),
                    ),
                    // ignore: deprecated_member_use
                    FlatButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Tidak menerima code? ",
                            style: sansPro(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Kirim Ulang",
                            style: sansPro(
                                color: primaryColor,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      onPressed: manyRequest.isNotEmpty
                          ? null
                          : () async {
                              progressDialog(this.context);
                              await Firebase.initializeApp();
                              await credetialAuth();
                              await Future.delayed(Duration(seconds: 3), () {
                                Navigator.pop(context);
                              });
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
