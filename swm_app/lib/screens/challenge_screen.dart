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
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text('In Progress'),
          children: <Widget>[
            ListTile(
              title: Text('Food Waste'),
              subtitle: Text('click on this to enter food waste challenge'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ChallengeMain()));
              },
            ),
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
