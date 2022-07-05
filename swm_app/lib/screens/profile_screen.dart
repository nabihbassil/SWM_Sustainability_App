import 'package:flutter/material.dart';
import 'package:swm_app/screens/badges.dart';
import 'package:swm_app/screens/levels.dart';
<<<<<<< Updated upstream
=======
import 'package:swm_app/services/user_service.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
>>>>>>> Stashed changes

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
<<<<<<< Updated upstream
=======
  final Query _badgesearned = FirebaseFirestore.instance.collection('badges');
  int points = 800;
  int leveltotal = 1000;
  int level = 1;
  UserModel userData = UserModel();

  fetchUserData() async {
    userData = await UserService().getUserData();

    setState(() {
      userData;
    });
  }

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                  color: Color.fromARGB(255, 195, 195, 195),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(height: 60),
=======
                width: 130.0,
                height: 130.0,
                child: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  backgroundImage: NetworkImage(
                      "${userData.imgURL ?? "https://soccerpointeclaire.com/wp-content/uploads/2021/06/default-profile-pic-e1513291410505.jpg"}"),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "${userData.firstName ?? ""} ${userData.lastName ?? ""}",
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
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                          child: Text(
                        "Levels Overview",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 85, 148, 75),
                            fontWeight: FontWeight.bold),
                      )))),
              const SizedBox(height: 50),
=======
                          child:
                              Stack(clipBehavior: Clip.none, children: <Widget>[
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 140,
                          child: Container(
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
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 85, 148, 75),
                                  fontWeight: FontWeight.bold),
                            )),
                        Positioned(
                            bottom: 67,
                            left: 166,
                            child: Text(level.toString(),
                                textAlign: TextAlign.left,
                                style: GoogleFonts.arvo(
                                  textStyle: TextStyle(
                                      fontSize: 32,
                                      color: Color.fromARGB(255, 208, 166, 15),
                                      fontWeight: FontWeight.bold),
                                ))),
                        Positioned(
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
                            child: Container(
                              width: 340,
                              child: LinearPercentIndicator(
                                animateFromLastPercent: true,
                                animationDuration: 5000,
                                barRadius: const Radius.circular(16.0),
                                lineHeight: 10,
                                percent: points / leveltotal,
                                backgroundColor:
                                    Color.fromARGB(255, 167, 196, 161),
                                progressColor: Color.fromARGB(255, 23, 141, 4),
                              ),
                            )),
                        Positioned(
                            bottom: 3,
                            right: 57,
                            child: Text(
                              points.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color.fromARGB(255, 132, 168, 116),
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                        Positioned(
                            bottom: 3,
                            right: 20,
                            child: Text(
                              " / " + leveltotal.toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 135, 135, 135),
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
>>>>>>> Stashed changes
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
