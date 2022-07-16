import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/model/levels_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/services/user_service.dart';
import 'package:swm_app/model/user_model.dart';

class Levels extends StatefulWidget {
  const Levels({Key? key}) : super(key: key);

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  int points = 0;
  int leveltotal = 10000;
  int level = 0;
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
                                  'SWM will plant 5 trees in partnership with Bäume fürs Leben on your behalf',
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
                                      color: Color.fromARGB(255, 106, 132, 102),
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
                                const Text(
                                  "/1000",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 168, 168, 168),
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
                                  maxWidth: 80,
                                  maxHeight: 60,
                                ),
                                child: Image.asset("assets/level2icon.png"),
                              ),
                              title: const Text("Level 2 ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 54, 52, 52),
                                      fontWeight: FontWeight.bold)),
                              subtitle: const Text(
                                  'SWM will provide this reward',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 123, 123, 123),
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
                                  maxWidth: 80,
                                  maxHeight: 60,
                                ),
                                child: Image.asset("assets/level3icon.png"),
                              ),
                              title: const Text("Level 3 ",
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 54, 52, 52),
                                      fontWeight: FontWeight.bold)),
                              subtitle: const Text('SWM will provide',
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 123, 123, 123),
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
              ],
            ),
          ),
        ));
  }
}
