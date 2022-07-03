import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/services/user_service.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  List LProgress = ['0'];
  List LDone = ['0'];
  List LNew = ['0'];

  GetAllModulesDone() async {
    await UserService().GetAllModulesDone().then((value) => LDone = value);
    if (mounted) {
      setState(() {
        LDone;
        LNew = LDone + LProgress;
      });
    }
  }

  GetAllModulesInProgress() async {
    await UserService()
        .GetAllModulesInProgress()
        .then((value) => LProgress = value);
    print("print progreesss $LProgress");
    if (mounted) {
      setState(() {
        LProgress;
        LNew = LDone + LProgress;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    GetAllModulesInProgress();
    GetAllModulesDone();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "Challenges",
            style: TextStyle(
                fontSize: 30,
                color: Color.fromARGB(255, 80, 80, 80),
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 252, 248, 239),
            child: ExpansionTile(
                title: const Text('In Progress',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 80, 80, 80),
                        fontWeight: FontWeight.bold)),
                children: [
                  // I'll name the data fr
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('modules')
                              .where("modID", whereIn: LProgress)
                              .get(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading...'));
                            }
                            return Expanded(
                                child: ListView(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((item) {
                                return Center(
                                  child: Row(children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 155,
                                          child: Text(
                                            item['modName'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 131, 131, 131),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChallengeMain(
                                                          id: item['modID'],
                                                          name: item['modName'],
                                                        )));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24),
                                            height: 150,
                                            width: 200,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    item['modIMG'],
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  Container(height: 10),
                                                  FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Container(
                                                        width: 100,
                                                        child: Text(
                                                          item['category']
                                                              .replaceAll(
                                                                  "\\n", "\n"),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                );
                              }).toList(),
                            ));
                          })),
                ])),
        Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 238, 247, 249),
            child: ExpansionTile(
              title: Text('Discover New',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 80, 80),
                      fontWeight: FontWeight.bold)),
              children: [
                // I'll name the data fr
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection('modules')
                            .where("modID", whereNotIn: LNew)
                            .get(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(child: Text('Loading...'));
                          }
                          return Expanded(
                              child: ListView(
                            shrinkWrap: false,
                            scrollDirection: Axis.horizontal,
                            children: snapshot.data!.docs.map((item) {
                              return Center(
                                child: Row(children: [
                                  Column(
                                    children: [
                                      Container(
                                        width: 155,
                                        child: Text(
                                          item['modName'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 131, 131, 131),
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChallengeMain(
                                                        id: item['modID'],
                                                        name: item['modName'],
                                                      )));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24),
                                          height: 150,
                                          width: 200,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Stack(
                                              children: [
                                                Image.network(
                                                  item['modIMG'],
                                                  fit: BoxFit.cover,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                ),
                                                FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Container(
                                                      width: 100,
                                                      child: Text(
                                                        item['category']
                                                            .replaceAll(
                                                                "\\n", "\n"),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ]),
                              );
                            }).toList(),
                          ));
                        })),
              ],
            )),
        Container(
            width: MediaQuery.of(context).size.width,
            color: Color.fromARGB(255, 245, 255, 243),
            child: ExpansionTile(
                title: const Text('Complete',
                    style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(255, 80, 80, 80),
                        fontWeight: FontWeight.bold)),
                children: [
                  // I'll name the data fr
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      child: FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('modules')
                              .where("modID", whereIn: LDone)
                              .get(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(child: Text('Loading...'));
                            }
                            return Expanded(
                                child: ListView(
                              shrinkWrap: false,
                              scrollDirection: Axis.horizontal,
                              children: snapshot.data!.docs.map((item) {
                                return Center(
                                  child: Row(children: [
                                    Column(
                                      children: [
                                        Container(
                                          width: 155,
                                          child: Text(
                                            item['modName'],
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 131, 131, 131),
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChallengeMain(
                                                          id: item['modID'],
                                                          name: item['modName'],
                                                        )));
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 24),
                                            height: 150,
                                            width: 200,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Stack(
                                                children: [
                                                  Image.network(
                                                    item['modIMG'],
                                                    fit: BoxFit.cover,
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                  ),
                                                  Container(height: 10),
                                                  FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Container(
                                                        width: 100,
                                                        child: Text(
                                                          item['category']
                                                              .replaceAll(
                                                                  "\\n", "\n"),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ]),
                                );
                              }).toList(),
                            ));
                          })),
                ])),
      ],
    );
  }
}
