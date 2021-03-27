import 'package:book_app/constant/constantFile.dart';
import 'package:book_app/mainMenu.dart';

import 'package:book_app/page_register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

// deklarasi variable
enum statusLogin { signIn, notSignIn }

class _PageLoginState extends State<PageLogin> {
  statusLogin _loginStatus = statusLogin.notSignIn;
  final _keyForm = GlobalKey<FormState>();
  String nUsername, nPassword;
// check ketika klik tombol login
  checkForm() {
    final form = _keyForm.currentState;
    if (form.validate()) {
      form.save();

      submitDataLogin();
    }
  }


// mengirim request dan menanggapinya
  submitDataLogin() async {
    final responseData =
        await http.post(BaseUrl.login, body: {
      "username": nUsername,
      "password": nPassword,
    });
    final data = jsonDecode(responseData.body);
    int value = data['value'];
    String pesan = data['message'];
    print(data);
// get data respon
    String dataUsername = data['username'];
    String dataEmail = data['email'];
    String dataAlamat = data['alamat'];
    String dataJenis = data['jenis_kelamin'];
    String dataFullname = data['nama'];
    String dataTanggalDaftar = data['tgl_daftar'];
    String dataIdUser = data['id_user'];
// cek value 1 atau 0
    if (value == 1) {
      setState(() {
// set status loginnya sebagai login
        _loginStatus = statusLogin.signIn;
      //  print(dataEmail);

// simpan data ke share preferences
        saveDataPref(value, dataIdUser, dataUsername, dataEmail, dataAlamat,
            dataJenis, dataFullname, dataTanggalDaftar);
      });
    } else if (value == 2) {
      return showDialog<void>(
        context: context,
        barrierDismissible:
        false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(pesan),

                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  'Ok',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print(pesan);
    } else {
      return showDialog<void>(
        context: context,
        barrierDismissible:
        false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Failed'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(pesan),

                ],
              ),
            ),
            actions: <Widget>[
              RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  'Ok',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      print(pesan);
    }
  }


// method untuk soimpan share pref
  saveDataPref(int value, String dIdUser, dUsername, dEmail, dAlamat, dSex,
      dFullName, dCreated) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('email', dEmail);
    setState(() {
      sharedPreferences.setInt("value", value);
      sharedPreferences.setString("username", dUsername);
      sharedPreferences.setString("id_users", dIdUser);
      sharedPreferences.setString("email", dEmail);
      sharedPreferences.setString("alamat", dAlamat);
      sharedPreferences.setString("jenis_kelamin", dSex);
      sharedPreferences.setString("full_name", dFullName);
      sharedPreferences.setString("tgl_daftar", dCreated);
      sharedPreferences.commit();
    });
  }

  ///
  /// method ini digunakan untuk mengecek apakah user sudah login atau  belum
  /// jika sudah set valuenya
  ///
  getDataPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      int nvalue = sharedPreferences.getInt("value");
      String value = sharedPreferences.getString("email");
      print(value);
      _loginStatus = nvalue == 1 ? statusLogin.signIn : statusLogin.notSignIn;
    });
  }
  _tes() async {
  SharedPreferences sharedPreferences = await  SharedPreferences.getInstance();
  await sharedPreferences.setString('email', 'okee');
}
  @override
  void initState() {

    getDataPref();


    super.initState();
  }

//method untuk sign out
  signOUt() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sharedPreferences.setInt("value", null);
      sharedPreferences.commit();
      _loginStatus = statusLogin.notSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case statusLogin.notSignIn:
        return Scaffold(
          backgroundColor: Colors.white,
          body: Form(
            key: _keyForm,
            child: ListView(
              children: <Widget>[
                Center(
                  child: Text(
                    'Login Form',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Image.asset(
                  'images/udacoding.png',
                  height: 100.0,
                  width: 100.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    validator: (value) {
//cek kalau value nya kosong
                      if (value.isEmpty) {
                        return 'Please Input Username';
                      }
                      return null;
                    },
                    onSaved: (value) => nUsername = value,
                    decoration: InputDecoration(
                        hintText: 'Username',
                        labelText: 'Input Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Input Password';
                      }
                      return null;
                    },
                    onSaved: (value) => nPassword = value,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        labelText: 'Input Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0),
                  child: MaterialButton(
                    color: Colors.lightBlueAccent,
                    textColor: Colors.white,
                    child: Text('Login'),
                    onPressed: () {
                      setState(() {
                        checkForm();
                        _tes();
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
                  child: MaterialButton(
                    textColor: Colors.lightBlueAccent,
                    child: Text('Belum Punya Akun ? Silahkan Daftar'),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PageRegister()));
                    },
                  ),
                )
              ],
            ),
          ),
        );
        break;
      case statusLogin.signIn:
        return MainMenu(signOUt);
        break;
    }
  }
}
