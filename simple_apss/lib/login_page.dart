import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 64),
              Icon(
                Icons.person,
                size: 120,
                color: Colors.white,
              ),
              Text(
                "Login User",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
              SizedBox(height: 64),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  decoration: InputDecoration(hintText: "Email Address"),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(hintText: "Password"),
                ),
              ),
              SizedBox(height: 64),
              Container(
                height: 45,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 32),
                child: RaisedButton(
                  color: Colors.white,
                  child: Text("Login"),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 32),
                height: 45,
                child: RaisedButton(
                  color: Colors.white,
                  child: Text("Register"),
                  onPressed: () {},
                ),
              ),
              RaisedButton(
                color: Colors.white,
                child: Text("Back Home"),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
