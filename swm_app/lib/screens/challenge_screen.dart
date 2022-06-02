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
                return const Center(child: Text('Loading'));
              }
              return ListView(
                children: snapshot.data!.docs.map((item) {
                  return Center(
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Text(
                          item['awatitle'],
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.greenAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(item['awatext'].replaceAll("\\n", "\n")),
                        Image.network(
                            'https://googleflutter.com/sample_image.jpg'),
                      ],
                    )),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
