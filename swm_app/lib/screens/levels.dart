import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/model/levels_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/services/user_service.dart';
import 'package:swm_app/model/user_model.dart';

/* 
  This screen is the levels page of the app where users can see what users can win
  in donations from each level completed
  
*/
class Levels extends StatefulWidget {
  const Levels({Key? key}) : super(key: key);

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  List _levelsList = []; //list of levels available

  int points = 0; //user points
  int level = 0; //user level
  int leveltotal = 10000; //total points of a certain level
  UserModel userData = UserModel(); //instance of user data model

/* 
  This method retrieves from user services data about the logged in user

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * data is added to the instance of user data model added to the state
  
*/
  fetchUserData() async {
    //call to retrieve data
    userData = await UserService().getUserData();

    setState(() {
      userData; //retrieved user data
      points = userData.points!; //current user points
    });
  }

/* 
  This method retrieves the levels and their corresponding info

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * Set the current level of the user and display it on the interface
  
*/
  Future getLevelList() async {
    // await fetchUserData();

    //database call
    var datas = await FirebaseFirestore.instance
        .collection('Levels')
        .orderBy('levelID', descending: false)
        .get();

    //filling results in list
    List _levelsLst = datas.docs
        .map((doc) => Level(
              description: doc.get("description"),
              levelID: doc.get("levelID"),
              lvlpoints: doc.get("lvlpoints"),
            ))
        .toList();

    //if user has more points than the level max points then he is next level
    int counter = 0;
    for (var i = 0; i < _levelsLst.length; i++) {
      if (points > _levelsLst[i].lvlpoints) {
        counter = counter + 1;
      } else {
        break;
      }
    }

    debugPrint(counter.toString());
    //set the total points of the current level
    int totalpts = _levelsLst[counter].lvlpoints!;

    setState(() {
      datas;
      _levelsList = _levelsLst;
      level = counter + 1;
      leveltotal = totalpts;
    });
  }

/*
On init, we fetch user data and then based on that load the levels and deduce the user's current level
*/
  @override
  void initState() {
    super.initState();
    fetchUserData(); //get user data
    getLevelList(); //get levels
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 243, 228),
        appBar: AppBar(
          title: Image.asset(
            "assets/SWM.png",
            height: 100,
            width: 100,
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //if user is on level 1
                if (points <= 1000) ...[
                  const Text(
                    "Levels Overview",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 45, 75, 40),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 350.00,
                    height: 30.00,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/comillas.png'),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        )),
                  ),
                  Container(
                      width: 350,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      //info about level 1
                      child: const Text(
                        'Our points reflects the knowledge you have gained for a better understanding of sustainability as well as your individual actions towards a more sustainable lifestyle.\n\n Your points are accumulated and help you to reach certain levels. For each you level you receive an award. Scroll down to see what each level might offer.       ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 98, 119, 95),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      )),
                  Container(
                      width: 350.00,
                      height: 30.00,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/comillas2.png'),
                          fit: BoxFit.fitWidth,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      )),
                  Container(height: 15),
                  SizedBox(
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 360.00,
                              height: 130,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 247, 255, 239),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: ListTile(
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 80,
                                    minHeight: 50,
                                    maxWidth: 100,
                                    maxHeight: 60,
                                  ),
                                  child: Image.asset("assets/level1icon.png"),
                                ),
                                title: const Text("Level 1 ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 2, 2, 2),
                                        fontWeight: FontWeight.bold)),
                                subtitle: const Text(
                                    'SWM will plant a tree in partnership with PLANT-MY-TREE on your behalf.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 69, 109, 62),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)),
                                isThreeLine: true,
                              ),
                            ),
                          ),
                          Container(height: 5),
                          Positioned(
                            bottom: 30,
                            right: 30,
                            child: SizedBox(
                              width: 300,
                              child: LinearPercentIndicator(
                                animateFromLastPercent: true,
                                animationDuration: 5000,
                                barRadius: const Radius.circular(16.0),
                                lineHeight: 10,
                                percent: points / leveltotal,
                                backgroundColor:
                                    const Color.fromARGB(255, 212, 240, 204),
                                progressColor:
                                    const Color.fromARGB(255, 23, 141, 4),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 4,
                            right: 30,
                            child: SizedBox(
                              width: 300,
                              child: Row(
                                children: [
                                  const Text(
                                    'Your progress',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 106, 132, 102),
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic),
                                  ),
                                  const Spacer(),
                                  Text(
                                    points.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 95, 135, 89),
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "/" + leveltotal.toString(),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 168, 168, 168),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  SizedBox(
                    height: 70,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 350.00,
                              height: 140,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 249, 249, 249),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: ListTile(
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 60,
                                    minHeight: 50,
                                    maxWidth: 65,
                                    maxHeight: 60,
                                  ),
                                  child: Image.asset(
                                      "assets/level2iconshadow.png"),
                                ),
                                title: const Text("Level 2 ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 54, 52, 52),
                                        fontWeight: FontWeight.bold)),
                                subtitle: const Text(
                                    'In partnership with "Bio-Brotbox", a meal is donated to a school child.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 123, 123, 123),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)),
                                isThreeLine: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(height: 15),
                  SizedBox(
                    height: 70,
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              width: 340.00,
                              height: 140,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 249, 249, 249),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: ListTile(
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 60,
                                    minHeight: 50,
                                    maxWidth: 65,
                                    maxHeight: 60,
                                  ),
                                  child: Image.asset(
                                      "assets/level3iconshadow.png"),
                                ),
                                title: const Text("Level 3 ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 54, 52, 52),
                                        fontWeight: FontWeight.bold)),
                                subtitle: const Text(
                                    'SWM donates 10€ to LBV for the preservation of endangered nature.',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 123, 123, 123),
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic)),
                                isThreeLine: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  //level 2 description
                  if (points <= 2500) ...[
                    const Text(
                      "Levels Overview",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 45, 75, 40),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 350.00,
                      height: 30.00,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/comillas.png'),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                    ),
                    Container(
                        width: 350,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        //description of level 2
                        child: const Text(
                          'Our points reflects the knowledge you have gained for a better understanding of sustainability as well as your individual actions towards a more sustainable lifestyle.\n\n Your points are accumulated and help you to reach certain levels. For each you level you receive an award. Scroll down to see what each level might offer.       ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 98, 119, 95),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        width: 350.00,
                        height: 30.00,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/comillas2.png'),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        )),
                    Container(height: 15),
                    SizedBox(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 360.00,
                                height: 70,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 249, 249, 249),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 60,
                                      minHeight: 50,
                                      maxWidth: 65,
                                      maxHeight: 60,
                                    ),
                                    child: Image.asset(
                                        "assets/level1iconshadow.png"),
                                  ),
                                  title: const Text("Level 1 ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 54, 52, 52),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'SWM will plant a tree in partnership with PLANT-MY-TREE on your behalf.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 123, 123, 123),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                            Container(height: 5),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 15),
                    SizedBox(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 360.00,
                                height: 130,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 247, 255, 239),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 80,
                                      minHeight: 50,
                                      maxWidth: 100,
                                      maxHeight: 60,
                                    ),
                                    child: Image.asset("assets/level2icon.png"),
                                  ),
                                  title: const Text("Level 2 ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 2, 2, 2),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'In partnership with "Bio-Bortbox", a meal is donated to a school child.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 69, 109, 62),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                            Container(height: 5),
                            Positioned(
                              bottom: 30,
                              right: 30,
                              child: SizedBox(
                                width: 300,
                                child: LinearPercentIndicator(
                                  animateFromLastPercent: true,
                                  animationDuration: 5000,
                                  barRadius: const Radius.circular(16.0),
                                  lineHeight: 10,
                                  percent: points / leveltotal,
                                  backgroundColor:
                                      const Color.fromARGB(255, 212, 240, 204),
                                  progressColor:
                                      const Color.fromARGB(255, 23, 141, 4),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 30,
                              child: SizedBox(
                                width: 300,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Your progress',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 106, 132, 102),
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const Spacer(),
                                    Text(
                                      points.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 95, 135, 89),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "/" + leveltotal.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 168, 168, 168),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 15),
                    SizedBox(
                      height: 70,
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 340.00,
                                height: 140,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 249, 249, 249),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 60,
                                      minHeight: 50,
                                      maxWidth: 80,
                                      maxHeight: 60,
                                    ),
                                    child: Image.asset(
                                        "assets/level3iconshadow.png"),
                                  ),
                                  title: const Text("Level 3 ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 54, 52, 52),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'SWM donates 10€ to LBV for the preservation of endangered nature.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 123, 123, 123),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ] else ...[
                    //level 3
                    const Text(
                      "Levels Overview",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color.fromARGB(255, 45, 75, 40),
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 350.00,
                      height: 30.00,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/comillas.png'),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                    ),
                    Container(
                        width: 350,
                        color: const Color.fromARGB(255, 255, 255, 255),
                        //info about level 3
                        child: const Text(
                          'Our points reflects the knowledge you have gained for a better understanding of sustainability as well as your individual actions towards a more sustainable lifestyle.\n\n Your points are accumulated and help you to reach certain levels. For each you level you receive an award. Scroll down to see what each level might offer.       ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 98, 119, 95),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        width: 350.00,
                        height: 30.00,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ExactAssetImage('assets/comillas2.png'),
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        )),
                    Container(height: 15),
                    SizedBox(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 360.00,
                                height: 70,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 249, 249, 249),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 60,
                                      minHeight: 50,
                                      maxWidth: 65,
                                      maxHeight: 60,
                                    ),
                                    child: Image.asset(
                                        "assets/level1iconshadow.png"),
                                  ),
                                  title: const Text("Level 1 ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 54, 52, 52),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'SWM will plant a tree in partnership with PLANT-MY-TREE on your behalf.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 123, 123, 123),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                            Container(height: 5),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 15),
                    SizedBox(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 360.00,
                                height: 70,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 249, 249, 249),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 60,
                                      minHeight: 50,
                                      maxWidth: 65,
                                      maxHeight: 60,
                                    ),
                                    child: Image.asset(
                                        "assets/level2iconshadow.png"),
                                  ),
                                  title: const Text("Level 2 ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 54, 52, 52),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'In partnership with "Bio-Bortbox", a meal is donated to a school child.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Color.fromARGB(
                                              255, 123, 123, 123),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                            Container(height: 5),
                          ],
                        ),
                      ),
                    ),
                    Container(height: 15),
                    SizedBox(
                      child: Center(
                        child: Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 360.00,
                                height: 130,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 247, 255, 239),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: ListTile(
                                  leading: ConstrainedBox(
                                    constraints: const BoxConstraints(
                                      minWidth: 80,
                                      minHeight: 50,
                                      maxWidth: 100,
                                      maxHeight: 60,
                                    ),
                                    child: Image.asset("assets/level3icon.png"),
                                  ),
                                  title: const Text("Level 3 ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(255, 2, 2, 2),
                                          fontWeight: FontWeight.bold)),
                                  subtitle: const Text(
                                      'SWM donates 10€ to LBV for the preservation of endangered nature.',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Color.fromARGB(255, 69, 109, 62),
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic)),
                                  isThreeLine: true,
                                ),
                              ),
                            ),
                            Container(height: 5),
                            Positioned(
                              bottom: 30,
                              right: 30,
                              child: SizedBox(
                                width: 300,
                                child: LinearPercentIndicator(
                                  animateFromLastPercent: true,
                                  animationDuration: 5000,
                                  barRadius: const Radius.circular(16.0),
                                  lineHeight: 10,
                                  percent: points / leveltotal,
                                  backgroundColor:
                                      const Color.fromARGB(255, 212, 240, 204),
                                  progressColor:
                                      const Color.fromARGB(255, 23, 141, 4),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 30,
                              child: SizedBox(
                                width: 300,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Your progress',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 106, 132, 102),
                                          fontSize: 14,
                                          fontStyle: FontStyle.italic),
                                    ),
                                    const Spacer(),
                                    Text(
                                      points.toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color:
                                              Color.fromARGB(255, 95, 135, 89),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "/" + leveltotal.toString(),
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Color.fromARGB(
                                              255, 168, 168, 168),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ],
              ],
            ),
          ),
        ));
  }
}
