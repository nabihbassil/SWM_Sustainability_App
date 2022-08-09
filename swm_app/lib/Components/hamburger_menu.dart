import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/login_screen.dart';

/* 
  This component is used in ./pageholder.dart. It displays the Hamburger Menu Widget.

  Inputs:
  NO INPUTS

  Outputs:
  * HamburgerMenu object containg header containing user data.
  * A button used for the logout functionality.
  
*/
class HamburgerMenu extends StatefulWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  _HamburgerMenu createState() => _HamburgerMenu();
}

class _HamburgerMenu extends State<HamburgerMenu> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

/*
In initState we are retrieving logged in user data from The Firebase using the
user ID we got from the Firebase functionality to save locally the current user 
on login. This data is retrieved to be displayed in the HamburgerMenu.
 */
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        loggedInUser;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(height: 25),
          SizedBox(
            height: 90.0,
            width: 90,
            child: DrawerHeader(
                child: ListTile(
                  title: Text(
                      "${loggedInUser.firstName} ${loggedInUser.lastName}"),
                  subtitle: Text("${loggedInUser.email}"),
                ),
                decoration: const BoxDecoration(color: Colors.blueAccent),
                margin: EdgeInsets.zero,
                padding: EdgeInsets.all(2)),
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

/* 
In this function, user is signed out. An integrated Firebase function is used
to dispose user data and related tokens. Afterwards, users are redirected to
the login screen.
*/
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()));
  }
}
