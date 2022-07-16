import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/model/user_model.dart';
import 'package:swm_app/model/levels_model.dart';
import 'package:swm_app/screens/badges.dart';
import 'package:swm_app/screens/levels.dart';
import 'package:swm_app/services/user_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final Query _badgesearned = FirebaseFirestore.instance.collection('badges');
  int points = 0;
  int level = 0;
  int leveltotal = 10000;
  List _levelsList = [];
  UserModel userData = UserModel();

  fetchUserData() async {
    userData = await UserService().getUserData();

    setState(() {
      userData;
      points = userData.points!;
    });
  }

  Future getLevelList() async {
    print("p1");

    var datas = await FirebaseFirestore.instance
        .collection('Levels')
        .orderBy('levelID', descending: false)
        .get();

    print("p2");
    List _levelsLst = datas.docs
        .map((doc) => Level(
              description: doc.get("description"),
              levelID: doc.get("levelID"),
              lvlpoints: doc.get("lvlpoints"),
            ))
        .toList();

    print("p3 $_levelsLst");

    int counter = 0;
    for (var i = 0; i < _levelsLst.length; i++) {
      if (points > _levelsLst[i].lvlpoints) {
        counter = counter + 1;
      } else {
        break;
      }
    }
    print("p4 $counter");

    debugPrint(counter.toString());
    int totalpts = _levelsLst[counter].lvlpoints!;

    print("p5 $totalpts");

    setState(() {
      datas;
      _levelsList = _levelsLst;
      level = counter + 1;
      leveltotal = totalpts;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
    getLevelList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 130.0,
                height: 130.0,
                child: CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                  backgroundImage: NetworkImage(userData.imgURL ??
                      "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg"),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${userData.firstName ?? ""} ${userData.lastName ?? ""}",
                style: const TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 70, 70, 70),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                    "Sustainability Level",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 99, 99, 99),
                        fontWeight: FontWeight.bold),
                  ))),
              const SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Levels()));
                  },
                  // change to navigation to awareness screen
                  child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                          child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: <Widget>[
                            Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 224, 239, 242),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            Positioned(
                              bottom: 95,
                              child: Container(
                                  height: 10,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 224, 239, 242),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                            const Positioned(
                              bottom: 40,
                              child: SizedBox(
                                height: 75,
                                child: Image(
                                  image: AssetImage('assets/levelicon.png'),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 35,
                                left: 15,
                                child: Text(
                                  "Level " + level.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 148, 75),
                                      fontWeight: FontWeight.bold),
                                )),
                            Positioned(
                                bottom: 67,
                                child: Text(level.toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          fontSize: 32,
                                          color:
                                              Color.fromARGB(255, 208, 166, 15),
                                          fontWeight: FontWeight.bold),
                                    ))),
                            const Positioned(
                                top: 8,
                                right: 15,
                                child: Text(
                                  "+",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 106, 144, 161),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Positioned(
                                bottom: 22,
                                left: 5,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.86,
                                  child: LinearPercentIndicator(
                                    animateFromLastPercent: true,
                                    animationDuration: 5000,
                                    barRadius: const Radius.circular(16.0),
                                    lineHeight: 10,
                                    percent: points / leveltotal,
                                    backgroundColor: const Color.fromARGB(
                                        255, 167, 196, 161),
                                    progressColor:
                                        const Color.fromARGB(255, 23, 141, 4),
                                  ),
                                )),
                            Positioned(
                              bottom: 3,
                              right: 20,
                              child: Row(children: [
                                Text(
                                  points.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 132, 168, 116),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " / " + leveltotal.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 135, 135, 135),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                            )
                          ])))),
              const Padding(
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                    "Badges",
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 99, 99, 99),
                        fontWeight: FontWeight.bold),
                  ))),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Badges()));
                  },
                  // change to navigation to tasks screen
                  child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 227, 227, 227),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Center(
                          child: Row(children: <Widget>[
                        const SizedBox(width: 10),
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
                                              child: SizedBox(
                                            height: 70,
                                            width: 75,
                                            child: Image(
                                                image: AssetImage(
                                                    "assets/badges/badge" +
                                                        item['icon'] +
                                                        ".png")),
                                          ));
                                        } else {
                                          return (const SizedBox.shrink());
                                        }
                                      }));
                                    }).toList()),
                              );
                            }),
                        const SizedBox(width: 10),
                        const SizedBox(
                          height: 22,
                          width: 15,
                          child: Image(
                            image: AssetImage('assets/moreicon.png'),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ])))),
            ],
          ),
        ),
      ),
    );
  }
}
