// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:swm_app/Components/hamburger_menu.dart';
import 'package:swm_app/screens/challenge_screen.dart';
import 'package:swm_app/screens/home_screen.dart';
import 'package:swm_app/screens/news_screen.dart';
import 'package:swm_app/screens/profile_screen.dart';
import 'package:swm_app/screens/take_actions.dart';

class PageHolder extends StatefulWidget {
  const PageHolder({Key? key}) : super(key: key);

  @override
  _PageHolderState createState() => _PageHolderState();
}

class _PageHolderState extends State<PageHolder> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[
      HomeScreen(),
      TakeAction(),
      NewsScreen(),
      ProfileScreen()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/SWM.png",
          height: 100,
          width: 100,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const HamburgerMenu(),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.home,
              color: Colors.grey,
            ),
            label: 'Home',
            activeIcon: Icon(
              Icons.home,
              color: Colors.lightBlue[600],
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.school,
              color: Colors.grey,
            ),
            label: 'Challenges',
            activeIcon: Icon(
              Icons.school,
              color: Colors.lightBlue[600],
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.newspaper,
              color: Colors.grey,
            ),
            label: 'News',
            activeIcon: Icon(
              Icons.newspaper,
              color: Colors.lightBlue[600],
            ),
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person,
              color: Colors.lightBlue[600],
            ),
          ),
        ],
        selectedItemColor: Colors.lightBlue[600],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
