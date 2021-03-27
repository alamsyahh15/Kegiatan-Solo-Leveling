import 'package:flutter/material.dart';
import 'package:book_app/viewTabs/book.dart';
import 'package:book_app/viewTabs/category.dart';
import 'package:book_app/viewTabs/profile.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;

  MainMenu(this.signOut);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  signOut() {
    setState(() {
      widget.signOut();
    });
  }

  String username = "", email = "";

  getPref() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      username = preferences.getString("username");
      email = preferences.getString("email");

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    print(username);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(

        body: TabBarView(
          children: [
            Book(),
            Category(),
            Profile(signOut),
          ],
        ),
        bottomNavigationBar: TabBar(
          labelColor: Colors.blueAccent,
          unselectedLabelColor: Colors.grey,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.library_books),
              text: "List Book",
            ),
            Tab(
              icon: Icon(Icons.category),
              text: "Category",
            ),
            Tab(
              icon: Icon(Icons.perm_contact_calendar),
              text: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
