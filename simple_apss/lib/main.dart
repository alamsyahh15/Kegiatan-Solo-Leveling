import 'package:flutter/material.dart';

import 'login_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  TextEditingController angka1 = TextEditingController();
  TextEditingController angka2 = TextEditingController();

  void hitung(double num1, double num2, BuildContext context) {
    /// Fungsi menghitung
    var hasil = num1 + num2;

    // Fungsi menampilkan dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Information !!!"),
        content: Text("Hasil dari $num1 ditambah $num2 adalah $hasil"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Container(child: Text("ASdsad")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: angka1,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: angka2,
            ),
            RaisedButton(
              color: Colors.red,
              child: Text("Hitung (+)"),
              textColor: Colors.white,
              onPressed: () {
                // Your Action
                var number1 = double.parse(angka1.text);
                var number2 = double.parse(angka2.text);
                print("Angka 1 : $number1, Angka2 : $number2");
                hitung(number1, number2, context);
              },
            ),
            RaisedButton(
              child: Text("Page Login"),
              textColor: Colors.white,
              color: Colors.amber,
              onPressed: () {
                // Navigation Page

                Navigator.push(context,
                    MaterialPageRoute(builder: (ontext) => LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
