import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final VoidCallback signOut;

  Profile(this.signOut);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  //mengambil nilai dari shared preferences

  getDataPref() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      String dataUsername = sharedPreferences.getString("username");
      String dataName = sharedPreferences.getString("nama");
      String dataEmail = sharedPreferences.getString("email");
      String dataAlamat = sharedPreferences.getString("alamat");
      String dataSex = sharedPreferences.getString("jenis_kelamin");
      String dataId = sharedPreferences.getString("id_user");

      saveDataPref(dataId, dataName, dataEmail, dataAlamat,
          dataSex);
    });
  }

  String a;
  var _cUserId = TextEditingController();
  var _cUsername = TextEditingController();
  var _cJK = TextEditingController();
  var _cEmail = TextEditingController();

  var _cAlamat = TextEditingController();

//deklarasi untuk masing-masing widget
  String nUsername, nJK, nEmail, nAlamat;

//menambahkan key form
  final _keyForm = GlobalKey<FormState>();

  saveDataPref(dIduser, dUsername, dEmail, dAlamat, dSex) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    setState(() {
      sharedPreferences.setString("id_user", dIduser);
      sharedPreferences.setString("username", dUsername);
      sharedPreferences.setString("email", dEmail);
      sharedPreferences.setString("alamat", dAlamat);
      sharedPreferences.setString("jenis_kelamin", dSex);
      sharedPreferences.commit();
    });
  }
  static _read() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('username');
    return value;
  }
  static _read0() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String value = prefs.getString('id_user');
    return value;
  }

  static _read1() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString("email");
    String a = value;
    print('$a');
    return a;
  }


  static _read2() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString("jenis_kelamin");
    String a = value;
    print('$a');
    return a;
  }

  static _read3() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString("alamat");
    String a = value;
    print('$a');
    return a;
  }


  @override
  void initState() {
    super.initState();
//     getDataPref();
    getDataPref();
    // _read();
//    _read1();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cUsername.text = await _read();
      _cUserId.text = await _read0();
      _cEmail.text = await _read1();
      _cAlamat.text = await _read3();
      _cJK.text = await _read2();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Form(
        key: _keyForm,
        child: ListView(
          children: <Widget>[
            Text(
              '',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                  color: Colors.lightBlueAccent),
            ),
            SizedBox(
              height: 20.0,
            ),
            Image.asset(
              'images/profil.png',
              height: 100.0,
              width: 100.0,
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                readOnly: true,
                controller: _cUsername,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Please Input UserName';
                  }
                  return null;
                },
                onSaved: (value) => nUsername = _cUsername.text,
                decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                readOnly: true,
                controller: _cEmail,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Please Input Email';
                  }
                  return null;
                },
                onSaved: (value) => nEmail = _cEmail.text,
                decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(

                readOnly: true,
                controller: _cJK,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Please Input Jenis Kelamin';
                  }
                  return null;
                },
                onSaved: (value) => nJK = _cJK.text,
                decoration: InputDecoration(
                    hintText: 'Jenis Kelamin',
                    labelText: 'Jenis Kelamin',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextFormField(
                readOnly: true,
                controller: _cAlamat,
                validator: (value) {
                  //cek kalau value nya kosong
                  if (value.isEmpty) {
                    return 'Please Input Alamat';
                  }
                  return null;
                },
                maxLines: 3,
                onSaved: (value) => nAlamat = _cAlamat.text,
                decoration: InputDecoration(
                    hintText: 'Alamat',
                    labelText: 'Alamat',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(120.0, 20.0, 120.0, 0),
              child: MaterialButton(
                color: Colors.lightBlueAccent,
                textColor: Colors.white,
                child: Text('Sign Out'),
                onPressed: () {
                  signOut();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
