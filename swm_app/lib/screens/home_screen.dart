// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            new SizedBox(
              height: 90.0,
              child: const DrawerHeader(
                  child: const Text('Nabih Bassil'),
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero),
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                logout(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
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
            icon: Icon(
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
            icon: Icon(
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
            icon: Icon(
              Icons.person,
              color: Colors.grey,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person,
              color: Colors.lightBlue[600],
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.paid,
              color: Colors.grey,
            ),
            label: 'Rewards',
            activeIcon: Icon(
              Icons.paid,
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

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
