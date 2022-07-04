import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:swm_app/screens/badges.dart';
import 'package:swm_app/screens/levels.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final Query _badgesearned = FirebaseFirestore.instance.collection('badges');
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 20),
              Container(
                width: 130.0,
                height: 130.0,
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 195, 195, 195),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Name",
                style: TextStyle(
                    fontSize: 25,
                    color: Color.fromARGB(255, 70, 70, 70),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Padding(
                  padding: EdgeInsets.only(right: 150),
                  child: Text(
                    "Sustainability Level",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 99, 99, 99),
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Levels()));
                  },
                  // change to navigation to awareness screen
                  child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 224, 239, 242),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                          child: Text(
                        "Level",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 85, 148, 75),
                            fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(height: 10),
              Padding(
                  padding: EdgeInsets.only(right: 270),
                  child: Text(
                    "Badges",
                    style: TextStyle(
                        fontSize: 22,
                        color: Color.fromARGB(255, 99, 99, 99),
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Badges()));
                  },
                  // change to navigation to tasks screen
                  child: Container(
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 227, 227, 227),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: StreamBuilder(
                            stream: _badgesearned.snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: Text('Loading...'));
                              }

                              return Expanded(
                                child: ListView(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    children: snapshot.data!.docs.map((item) {
                                      return Container(child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        if (item['earned'] == true) {
                                          return Center(
                                              child: Container(
                                            height: 70,
                                            width: 90,
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/badges/badge" +
                                                        item['icon'] +
                                                        ".png")),
                                          ));
                                        } else {
                                          return (SizedBox.shrink());
                                        }
                                      }));
                                    }).toList()),
                              );
                            }),
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
