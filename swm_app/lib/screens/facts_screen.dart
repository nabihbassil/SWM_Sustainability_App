import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/services/fact_service.dart';

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
  List userProfilesList = [];
  int size = 0;
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  @override
  Future<int> fetchDataSize() async {
    var respectsQuery = FirebaseFirestore.instance.collection('awafacts');
    var querySnapshot = await respectsQuery.get();
    var totalEquals = querySnapshot.docs.length;
    return totalEquals;
  }

  fetchDatabaseList() async {
    dynamic resultant = await FactService().getFactsList();

    if (resultant == null) {
      print('Unable to retrieve for some reason');
    } else {
      setState(() {
        userProfilesList = resultant;
        size = userProfilesList.length;
      });
      print("p2 $size");
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          height: 20,
                        ),
                        SizedBox(
                            height: 17,
                            width: 500,
                            child: Image.asset(
                              'assets/progressbarfact.png',
                              fit: BoxFit.contain,
                            )),
                        Container(
                          height: 30,
                        ),
                        Container(
                            width: 300,
                            child: Text(
                              "Did you know...",
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 18, 68, 10),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            )),
                        Container(height: 30),
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              width: 260,
                              child: Text(
                                item['awatext'].replaceAll("\\n", "\n"),
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        Container(height: 20),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.network(
                            item['awaimg'],
                            height: 170.0,
                          ),
                        ),
                        Container(height: 40),
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              width: 290,
                              child: Text(
                                "Swipe for more ➜",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 131, 131, 131),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
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
