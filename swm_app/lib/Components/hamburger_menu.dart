// ignore_for_file: unnecessary_const

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  _HamburgerMenu createState() => _HamburgerMenu();
}

class _HamburgerMenu extends State<HamburgerMenu> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 90.0,
            child: DrawerHeader(
                child: ListTile(
                  title: Text(
                      "${loggedInUser.firstName} ${loggedInUser.lastName}"),
                  subtitle: Text("${loggedInUser.email}"),
                ),
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
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
