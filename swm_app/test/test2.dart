import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Challenges",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
              StreamBuilder(
                  stream: _collectionRef.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
                    if (!snapshot1.hasData) {
                      return const Center(child: Text('Loading...'));
                    }
                    return Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      children: snapshot1.data!.docs.map((item1) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    // Foreground color
                                    onPrimary: Colors.lightGreen,
                                    // Background color
                                    primary: Colors.lightGreen),
                                onPressed: () {},
                                child: Text(
                                  item1['actiontitle'],
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        );
                      }).toList(),
                    ));
                  }),
            ]),
      ),
    );
  }
}
