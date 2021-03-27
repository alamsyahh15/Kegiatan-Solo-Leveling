import 'package:flutter/material.dart';
import 'package:ma_laundry/data/model/account_model.dart/account_model.dart';
import 'package:ma_laundry/ui/bloc/account_bloc/login_bloc.dart';
import 'package:ma_laundry/ui/config/export_config.dart';
import 'package:ma_laundry/ui/main/account_screen/input_number_page.dart';
import 'package:ma_laundry/utils/constant.dart';
import 'package:ma_laundry/utils/export_utils.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  User user = User();
  bool obSecure = true;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => LoginBloc(context, scaffoldKey: _key))
      ],
      child: Consumer<LoginBloc>(
        builder: (context, blocLogin, _) => Scaffold(
          key: _key,
          body: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(normal)),
                    child: Container(
                      width: widthScreen(context),
                      padding: EdgeInsets.symmetric(
                          horizontal: medium, vertical: high),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Image.asset(
                              '$libImage/logo_login.jpg',
                              width: 180,
                            ),
                          ),
                          SizedBox(height: medium),
                          CustomTextField(
                            label: "Username",
                            onChanged: (value) {
                              user?.username = value;
                            },
                          ),
                          SizedBox(height: medium),
                          CustomTextField(
                            label: "PIN",
                            keyboardType: TextInputType.number,
                            obscureText: obSecure,
                            suffixIcon: IconButton(
                              icon: Icon(obSecure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() => obSecure = !obSecure);
                              },
                            ),
                            onChanged: (value) {
                              user?.pin = value;
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: normal),
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                navigateTo(context, InputNumberPage());
                              },
                              child: Text("Reset PIN",
                                  style: sansPro(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ),
                          blocLogin.isLoading
                              ? Container(
                                  margin:
                                      EdgeInsets.symmetric(vertical: medium),
                                  child: circularProgressIndicator(),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: medium),
                                      height: 45,
                                      width: widthScreen(context),
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(normal)),
                                        color: primaryColor,
                                        textColor: whiteNeutral,
                                        child: Text("Login"),
                                        onPressed: () {
                                          blocLogin.loginUser(user);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
