import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
  }

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('awafacts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: _collectionRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return ListView(
                children: snapshot.data!.docs.map((item) {
                  return Center(
                    child: Container(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          item['awatitle'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(item['awatext'].replaceAll("\\n", "\n")),
                        SizedBox(
                          height: 200,
                          child: Image.network(item['awaimg']),
                        ),
                        Text(
                          item["ptsReward"] + "pts",
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.greenAccent,
                              fontStyle: FontStyle.italic),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // Foreground color
                                  onPrimary:
                                      Theme.of(context).colorScheme.onPrimary,
                                  // Background color
                                  primary:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {
                                  //Navigator.of(context).pop();
                                },
                                child: const Text('Back'),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  // Foreground color
                                  onPrimary:
                                      Theme.of(context).colorScheme.onPrimary,
                                  // Background color
                                  primary:
                                      Theme.of(context).colorScheme.primary,
                                ),
                                onPressed: () {},
                                child: const Text('Complete Action'),
                              )
                            ])
                      ],
                    )),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }

  Widget alreadyDone(done) {
    if (done) {}

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        // Foreground color
        onPrimary: Theme.of(context).colorScheme.onPrimary,
        // Background color
        primary: Theme.of(context).colorScheme.primary,
      ),
      onPressed: () {},
      child: const Text('Enabled'),
    );
  }
}
