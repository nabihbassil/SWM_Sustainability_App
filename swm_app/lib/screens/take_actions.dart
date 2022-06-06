import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/screens/challenge_screen.dart';

class TakeAction extends StatefulWidget {
  const TakeAction({Key? key}) : super(key: key);

  @override
  _TakeActionState createState() => _TakeActionState();
}

class _TakeActionState extends State<TakeAction> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final Query _collectionRef = FirebaseFirestore.instance
      .collection('takeactions')
      .where("done", isEqualTo: true);

  final Query _collectionRef1 = FirebaseFirestore.instance
      .collection('takeactions')
      .where("done", isEqualTo: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Tasks",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text("To DO",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.amber,
                      fontWeight: FontWeight.bold)),
              StreamBuilder(
                  stream: _collectionRef1.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: Text('Loading...'));
                    }
                    return Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((item) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    // Foreground color
                                    onPrimary: Colors.amber,
                                    // Background color
                                    primary: Colors.amber),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChallengeScreen(
                                          id: item['actionID'])));
                                },
                                child: Text(
                                  item['actiontitle'],
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
              const SizedBox(height: 20),
              const Text("Completed",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.greenAccent,
                      fontWeight: FontWeight.bold)),
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
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ChallengeScreen(
                                          id: item1['actionID'])));
                                },
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
