import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/services/fact_service.dart';
import 'package:swm_app/screens/quiz_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FactsScreen extends StatefulWidget {
  int index;
  FactsScreen({Key? key, required this.index}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<FactsScreen> createState() => _FactsScreenState(index);
}

class _FactsScreenState extends State<FactsScreen> {
  int _factIndex = 0;
  _FactsScreenState(this._factIndex);
  List userProfilesList = [];
  int size = 0;
  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  void _nextFact() {
    setState(() {
      _factIndex++;
    });
    // what happens at the end of the facts
    if (_factIndex >= 4) {
      _resetFacts();
    }
  }

  // function that describes what happens at the end of the facts
  void _resetFacts() {
    setState(() {
      _factIndex = 0;
    });
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
        .where("awaID", isEqualTo: _factIndex);

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
                        LinearPercentIndicator(
                          animateFromLastPercent: true,
                          animationDuration: 5000,
                          barRadius: const Radius.circular(16),
                          lineHeight: 20,
                          percent: (_factIndex) / 3,
                          backgroundColor: Color.fromARGB(255, 224, 223, 223),
                          progressColor: Color.fromARGB(255, 11, 88, 151),
                        ),
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
                        GestureDetector(
                            onTap: () {
                              if (_factIndex <= 2) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => FactsScreen(
                                          index: _factIndex,
                                        )));
                                _nextFact();
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => QuizScreen()));
                                _nextFact();
                                _resetFacts();
                              }
                            },
                            // change to navigation to awareness screen
                            child: FittedBox(
                                fit: BoxFit.fitHeight,
                                child: Container(
                                  width: 290,
                                  child: _factIndex >= 3
                                      ? Text(
                                          "Continue to Quiz➜",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 33, 36, 119),
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.right,
                                        )
                                      : Text(
                                          "Swipe for more ➜",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Color.fromARGB(
                                                  255, 131, 131, 131),
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.right,
                                        ),
                                ))),
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
