import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/screens/challenge_main.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  final Query _collectionRef = FirebaseFirestore.instance.collection('modules');

  @override
  void initState() {
    super.initState();
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
                      child: StreamBuilder(
                          stream: _collectionRef.snapshots(),
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
                                        Text(
                                          item['modName'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Color.fromARGB(
                                                  255, 131, 131, 131),
                                              fontWeight: FontWeight.w500),
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
                                                  Container(
                                                    color: Colors.black26,
                                                    child: Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            item['category'],
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
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
                    child: StreamBuilder(
                        stream: _collectionRef.snapshots(),
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
                                      Text(
                                        item['modName'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 131, 131, 131),
                                            fontWeight: FontWeight.w500),
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
                                                Container(
                                                  color: Colors.black26,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          item['category'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
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
              title: Text('Completed',
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 80, 80, 80),
                      fontWeight: FontWeight.bold)),
              children: [
                // I'll name the data fr
                SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
                    child: StreamBuilder(
                        stream: _collectionRef.snapshots(),
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
                                      Text(
                                        item['modName'],
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 131, 131, 131),
                                            fontWeight: FontWeight.w500),
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
                                                Container(
                                                  color: Colors.black26,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          item['category'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
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
      ],
    );
  }
}
