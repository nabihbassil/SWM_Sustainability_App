import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/services/fact_service.dart';
import 'package:swm_app/screens/quiz_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class FactsScreen extends StatefulWidget {
  int index;
  int id;
  String name;
  FactsScreen(
      {Key? key, required this.index, required this.id, required this.name})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<FactsScreen> createState() => _FactsScreenState(index, id, name);
}

class _FactsScreenState extends State<FactsScreen> {
  int _factIndex = 0;
  _FactsScreenState(this._factIndex, this.id, this.name);
  List userProfilesList = [];
  int size = 0;
  int id;
  String name;

  @override
  void initState() {
    super.initState();
    fetchDatabaseList(id);
  }

//add PreviousFact to go back too *important*

  void _nextFact() {
    setState(() {
      _factIndex++;
    });
    // what happens at the end of the facts
    if (_factIndex > size) {
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
  //Future<int> fetchDataSize() async {
  //var respectsQuery = FirebaseFirestore.instance
  //  .collection('awafacts')
  //  .where("parentmoduleid", isEqualTo: id);
  //var querySnapshot = await respectsQuery.get();
  //var totalEquals = querySnapshot.docs.length;
  //return totalEquals;
  //}

  fetchDatabaseList(id) async {
    dynamic resultant = await FactService().getUserTaskList(id);
    if (resultant == null) {
      print('Unable to retrieve for some reason');
    } else {
      setState(() {
        userProfilesList =
            resultant; //  <-----------  this contains all the data of facts use this with _factindex to load data *important*
        size = userProfilesList
            .length; //  <-----------  this contains size of the data use it to compare stuff related to size *important*
      });
      print("size $size  factindex is $_factIndex");
    }
  }

  @override
  Widget build(BuildContext context) {
    //print("fact nummer $_factIndex");
    //final Query _collectionRef = FirebaseFirestore.instance
    //.collection('awafacts')
    //.where("awaID", isEqualTo: _factIndex)
    //.where("parentmoduleid",
    //  isEqualTo:
    //    id); //  <-----------  remove this line dont load data from here *important*

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
              barRadius: const Radius.circular(16.0),
              lineHeight: 20,
              percent: _factIndex / size,
              backgroundColor: Color.fromARGB(255, 212, 240, 204),
              progressColor: Color.fromARGB(255, 23, 141, 4),
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
                    userProfilesList[_factIndex].awatext,
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
                userProfilesList[_factIndex].awaimg,
                height: 170.0,
              ),
            ),
            Container(height: 40),
            GestureDetector(
                onTap: () {
                  if (_factIndex < size - 1) {
                    print("iiiiiiiffffffff");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FactsScreen(
                              index: _factIndex,
                              id: id,
                              name: name,
                            )));
                    _nextFact();
                  } else {
                    print("eeeellllssseeeee");
                    _resetFacts();
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizScreen(
                              id: id,
                              name: name,
                            )));
                    //  _nextFact();

                  }
                },
                // change to navigation to awareness screen
                child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Container(
                        width: 290,
                        child: _factIndex < size - 1
                            ? Text(
                                "Next ➜",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 131, 131, 131),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              )
                            : Text(
                                "Continue to Quiz➜",
                                style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 33, 36, 119),
                                    fontWeight: FontWeight.normal),
                                textAlign: TextAlign.right,
                              )))),
          ],
        ),
      ),
    );
  }
}
