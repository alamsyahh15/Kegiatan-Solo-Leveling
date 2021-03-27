import 'package:flutter/material.dart';
import 'package:oyos_clone/screens/booking/booking_screen.dart';
import 'package:oyos_clone/screens/home/home_screen.dart';
import 'package:oyos_clone/screens/saved/saved_screen.dart';

class MainDashboard extends StatefulWidget {
  @override
  _MainDashboardState createState() => _MainDashboardState();
}

class _MainDashboardState extends State<MainDashboard> {
  int selectedIndex = 0;
  List<Widget> listScreen = [
    HomeScreen(),
    SavedScreen(),
    BookingScreen(),
    Center(child: Text("Account"))
  ];

  List<BottomNavigationBarItem> listItemBar = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite_border), title: Text("Saved")),
    BottomNavigationBarItem(
        icon: Icon(Icons.card_travel), title: Text("Booking")),
    BottomNavigationBarItem(
        icon: Icon(Icons.group_add), title: Text("Invite & Earn")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreen[selectedIndex],
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: BottomNavigationBar(
            items: listItemBar,
            type: BottomNavigationBarType.fixed,
            currentIndex: selectedIndex,
            showUnselectedLabels: true,
            unselectedItemColor: Colors.black54,
            selectedItemColor: Colors.red,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
