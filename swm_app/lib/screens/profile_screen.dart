import 'package:flutter/material.dart';
import 'package:swm_app/screens/badges.dart';
import 'package:swm_app/screens/levels.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Profile",
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 70, 70, 70),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 195, 195, 195),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 60),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Levels()));
                  },
                  // change to navigation to awareness screen
                  child: Container(
                      height: 100,
                      width: 200,
                      color: Color.fromARGB(255, 215, 240, 206),
                      child: Center(
                          child: Text(
                        "Levels Overview",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 85, 148, 75),
                            fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(height: 50),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Badges()));
                  },
                  // change to navigation to tasks screen
                  child: Container(
                      height: 100,
                      width: 200,
                      color: Color.fromARGB(255, 255, 239, 199),
                      child: Center(
                          child: Text(
                        "Badges",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 228, 169, 18),
                            fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(height: 7),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
