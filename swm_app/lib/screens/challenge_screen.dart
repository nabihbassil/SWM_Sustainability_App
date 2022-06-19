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
  Color _text1Color = Color.fromARGB(255, 50, 50, 50);
  Color _text2Color = Color.fromARGB(255, 50, 50, 50);
  Color _text3Color = Color.fromARGB(255, 50, 50, 50);

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
                  fontSize: 26,
                  color: Color.fromARGB(255, 60, 60, 60),
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
        ExpansionTile(
          initiallyExpanded: true,
          onExpansionChanged: (expanded) {
            setState(() {
              if (expanded) {
                _text1Color = Color.fromARGB(255, 123, 89, 2);
              } else {
                _text1Color = Color.fromARGB(255, 50, 50, 50);
              }
            });
          },
          title: Text(
            'In Progress',
            style: TextStyle(
              fontSize: 20,
              color: _text1Color,
            ),
          ),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          collapsedBackgroundColor: Color.fromARGB(255, 238, 247, 255),
          children: [
            // I'll name the data fr
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: StreamBuilder(
                    stream: _collectionRef.snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                        fontSize: 18,
                                        color: Color.fromARGB(255, 80, 80, 80),
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
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 24),
                                      height: 150,
                                      width: 200,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
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
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      item['category'],
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w500),
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
        ),
        ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              if (expanded) {
                _text2Color = Color.fromARGB(255, 45, 88, 1);
              } else {
                _text2Color = Color.fromARGB(255, 50, 50, 50);
              }
            });
          },
          title: Text('Discover New',
              style: TextStyle(
                fontSize: 20,
                color: _text2Color,
              )),
          children: <Widget>[
            ListTile(title: Text('This is tile number 2')),
          ],
        ),
        ExpansionTile(
          onExpansionChanged: (expanded) {
            setState(() {
              if (expanded) {
                _text3Color = Color.fromARGB(255, 5, 98, 132);
              } else {
                _text3Color = Color.fromARGB(255, 50, 50, 50);
              }
            });
          },
          title: Text('Completed',
              style: TextStyle(
                fontSize: 20,
                color: _text3Color,
              )),
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
      ],
    );
  }
}
