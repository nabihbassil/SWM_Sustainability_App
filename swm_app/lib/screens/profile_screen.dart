import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
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
                    fontSize: 22,
                    color: Color.fromARGB(255, 70, 70, 70),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.only(right: 170),
                  child: Text(
                    "Sustainability Level",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 99, 99, 99),
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Levels()));
                  },
                  // change to navigation to awareness screen
                  child: SizedBox(
                      height: 120,
                      width: 350,
                      child: Center(
                          child: Stack(clipBehavior: Clip.none,
                              //overflow: Overflow.visible,
                              children: <Widget>[
                            Container(
                                height: 90,
                                width: 350,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 224, 239, 242),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            Positioned(
                              bottom: 95,
                              child: Container(
                                  height: 10,
                                  width: 350,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 224, 239, 242),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                            Positioned(
                              bottom: 42,
                              left: 140,
                              child: Container(
                                height: 75,
                                child: Image(
                                  image: AssetImage('assets/levelicon.png'),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 40,
                                left: 15,
                                child: Text(
                                  "Level" + " 1",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 148, 75),
                                      fontWeight: FontWeight.bold),
                                )),
                            Positioned(
                                bottom: 70,
                                left: 166,
                                child: Text("1",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.arvo(
                                      textStyle: TextStyle(
                                          fontSize: 32,
                                          color:
                                              Color.fromARGB(255, 208, 166, 15),
                                          fontWeight: FontWeight.bold),
                                    ))),
                            Positioned(
                                top: 8,
                                right: 15,
                                child: Text(
                                  "+",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 106, 144, 161),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ])))),
              Padding(
                  padding: EdgeInsets.only(left: 35, right: 35),
                  child: Text(
                    "  Keep up the good work! Try some new tasks for a bonus reward when you reach the next level!",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 142, 142, 142),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.only(right: 280),
                  child: Text(
                    "Badges",
                    style: TextStyle(
                        fontSize: 20,
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
                      height: 100,
                      width: 350,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 227, 227, 227),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Row(children: <Widget>[
                        SizedBox(width: 10),
                        StreamBuilder(
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
                                            width: 75,
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
                        SizedBox(width: 10),
                        Container(
                          height: 22,
                          width: 18,
                          child: Image(
                            image: AssetImage('assets/moreicon.png'),
                          ),
                        ),
                        SizedBox(width: 12),
                      ])))),
            ],
          ),
        ),
      ),
    );
  }
}
