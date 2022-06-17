import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/model/facts_model.dart';

class FactsScreen extends StatefulWidget {
  int index;
  FactsScreen({Key? key, required this.index}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<FactsScreen> createState() => _FactsScreenState(index);
}

class _FactsScreenState extends State<FactsScreen> {
  int index;
  _FactsScreenState(this.index);

  @override
  Future<int> fetchDataSize() async {
    var respectsQuery = FirebaseFirestore.instance.collection('awafacts');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    print("qqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq  $totalEquals");
    return totalEquals;
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    Future<int> factsize = fetchDataSize().then((value) {
      print("123456  $value");
      return i = value;
    });

    final Query _collectionRef = FirebaseFirestore.instance
        .collection('awafacts')
        .where("awaID", isEqualTo: index);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/SWM.png",
          height: 100,
          width: 100,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 30,
                        ),
                        Container(
                            width: 300,
                            child: Text(
                              item['awatitle'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 18, 68, 10),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Container(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['awaimg'],
                            height: 170.0,
                          ),
                        ),
                        Container(height: 20),
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              width: 290,
                              child: Text(
                                item['awatext'].replaceAll("\\n", "\n"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.left,
                              ),
                            )),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}