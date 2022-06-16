import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/screens/challenge_main.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final Query _collectionRef = FirebaseFirestore.instance.collection('modules');

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ExpansionTile(
          title: Text('In Progress'),
          children: [
            // I'll name the data from firebase "datas"
            _collectionRef == null
                ? SizedBox.shrink()
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (ctx, index) {
                          return SizedBox(
                            width: 30,
                            height: 30,
                            child: Column(children: [
                              Text("text1"),
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("kkkkk"),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ]),
                          );
                        })),
          ],
        ),
        const ExpansionTile(
          title: Text('Discover New'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 2')),
          ],
        ),
        const ExpansionTile(
          title: Text('Completed'),
          children: <Widget>[
            ListTile(title: Text('This is tile number 3')),
          ],
        ),
      ],
    );
  }
}
