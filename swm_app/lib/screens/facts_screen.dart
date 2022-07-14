import 'package:flutter/material.dart';
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

  void _prevFact() {
    setState(() {
      _factIndex = _factIndex - 1;
    });
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                percent: (_factIndex + 1) / size,
                backgroundColor: const Color.fromARGB(255, 224, 223, 223),
                progressColor: const Color.fromARGB(255, 11, 88, 151),
              ),
              Container(
                height: 30,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  width: double.infinity,
                  child: Text(
                    userProfilesList[_factIndex].awatitle,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  )),
              Container(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                width: double.infinity,
                child: Text(
                  (userProfilesList[_factIndex].awatext)
                      .replaceAll("\\n", "\n"),
                  style: const TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left,
                ),
              ),
              Container(height: 20),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      userProfilesList[_factIndex].awaimg,
                      width: double.infinity,
                    ),
                  )),
              Container(height: 40),
              ListTile(
                //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
                title: Row(children: <Widget>[
                  Expanded(
                      child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            if (_factIndex > 0) {
                              print("iiiiiiiffffffff");
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FactsScreen(
                                        index: _factIndex,
                                        id: id,
                                        name: name,
                                      )));
                              _prevFact();
                            }
                          },
                          child: _factIndex > 0
                              ? FittedBox(
                                  fit: BoxFit.fitHeight,
                                  child: SizedBox(
                                      width: 160,
                                      child: Text(
                                        "< Back",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 131, 131, 131),
                                            fontWeight: FontWeight.normal),
                                        textAlign: TextAlign.left,
                                      )))
                              : FittedBox(fit: BoxFit.fitHeight))
                    ],
                  )),
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
                    child: FittedBox(
                        fit: BoxFit.fitHeight,
                        child: SizedBox(
                            width: 160,
                            child: _factIndex < size - 1
                                ? const Text(
                                    "Next >",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 131, 131, 131),
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.right,
                                  )
                                : const Text(
                                    "Continue to Quiz➜",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Color.fromARGB(255, 33, 36, 119),
                                        fontWeight: FontWeight.normal),
                                    textAlign: TextAlign.right,
                                  ))),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
