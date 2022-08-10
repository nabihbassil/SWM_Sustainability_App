// ignore_for_file: unnecessary_const
import 'package:flutter/material.dart';
import 'package:swm_app/Components/hamburger_menu.dart';
import 'package:swm_app/screens/challenge_screen.dart';
import 'package:swm_app/screens/home_screen.dart';
import 'package:swm_app/screens/news_screen.dart';
import 'package:swm_app/screens/profile_screen.dart';

/*
This is the main after log in screen where you can access the 4 main pages:
home page, challenges page, articles page and profile page.
This page is in a shape of a bottom bar menu for easy navigation
*/
class PageHolder extends StatefulWidget {
  const PageHolder({Key? key}) : super(key: key);

  @override
  _PageHolderState createState() => _PageHolderState();
}

class _PageHolderState extends State<PageHolder> {
  int _selectedIndex = 0; //index to which page we are in currently
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const List<Widget> _pages = <Widget>[
      HomeScreen(), //home page
      ChallengeScreen(), //modules page
      NewsScreen(), //articles page
      ProfileScreen() //profile page
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
      drawer: const HamburgerMenu(), //top left hamburger menu
      //display page of selected index based on bottom menu
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
            label: 'Articles',
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
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

//on click update index to clicked icon
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
