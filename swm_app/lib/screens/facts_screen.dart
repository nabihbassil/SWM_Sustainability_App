import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/awareness_main.dart';

import 'package:swm_app/screens/challenge_main.dart';

import 'package:swm_app/services/fact_service.dart';
import 'package:swm_app/screens/quiz_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
  int size = 1;
  int id;
  String name;

  @override
  void initState() {
    super.initState();
    print('print1 $size');
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

  void _resetFacts() {
    setState(() {
      _factIndex = 0;
    });
  }

  Future fetchDatabaseList(id) async {
    print('print3 $size   factindex  ${_factIndex + 1}');
    dynamic resultant = await FactService().getUserTaskList(id);
    if (resultant == null) {
      print('Unable to retrieve for some reason');
    } else {
      setState(() {
        resultant;
        userProfilesList =
            resultant; //  <-----------  this contains all the data of facts use this with _factindex to load data *important*
        size = userProfilesList
            .length; //  <-----------  this contains size of the data use it to compare stuff related to size *important*

        print('print4 $size   factindex  ${_factIndex + 1}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AwarenessMain(id: id, name: name))),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageHolder()));
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: fetchDatabaseList(id),
              initialData: userProfilesList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Center(child: Text('Loading...'));
                }

                return Padding(
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
                        backgroundColor:
                            const Color.fromARGB(255, 224, 223, 223),
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
                          child: Html(
                              data: (userProfilesList[_factIndex].awatext),
                              onLinkTap: (url, _, __, ___) async {
                                if (await canLaunchUrlString(url!)) {
                                  await launchUrlString(
                                    url,
                                    mode: LaunchMode.inAppWebView,
                                  );
                                }
                              },
                              style: {
                                "p": Style(
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: FontSize(16))
                              })),
                      Container(height: 20),
                      Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              userProfilesList[_factIndex].awaimg,
                              width: double.infinity,
                            ),
                          )),
                      Container(height: 40),
                      ListTile(
                        //contentPadding: EdgeInsets.all(<some value here>),//change for side padding
                        title: Row(children: <Widget>[
                          Expanded(
                              child: GestureDetector(
                                  onTap: () {
                                    if (_factIndex > 0) {
                                      print("iiiiiiiffffffff");
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
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
                                                    fontWeight:
                                                        FontWeight.normal),
                                                textAlign: TextAlign.left,
                                              )))
                                      : FittedBox(fit: BoxFit.fitHeight))),
                          Expanded(
                            child: GestureDetector(
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
                                                  color: Color.fromARGB(
                                                      255, 131, 131, 131),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.right,
                                            )
                                          : const Text(
                                              "Continue to Quiz➜",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Color.fromARGB(
                                                      255, 33, 36, 119),
                                                  fontWeight:
                                                      FontWeight.normal),
                                              textAlign: TextAlign.right,
                                            ))),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
