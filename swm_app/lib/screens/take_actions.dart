import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
      .collection('awafacts')
      .where("read", isEqualTo: true);

  final Query _collectionRef1 = FirebaseFirestore.instance
      .collection('awafacts')
      .where("read", isEqualTo: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: _collectionRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot1) {
              if (!snapshot1.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return StreamBuilder(
                stream: _collectionRef1.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot2) {
                  if (!snapshot2.hasData) {
                    return const Center(child: Text('Loading...'));
                  }
                  return ListView(
                    children: <Widget>[
                      ListView(
                        children: snapshot1.data!.docs.map((item) {
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
                              ],
                            )),
                          );
                        }).toList(),
                      ),
                      ListView(
                        children: snapshot2.data!.docs.map((item) {
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
                              ],
                            )),
                          );
                        }).toList(),
                      )
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
