import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/services/fact_service.dart';
import 'package:swm_app/screens/quiz_screen.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

/* 
  This screen is the Facts page where users can learn digestible information
  about the chosen topic

*/
class FactsScreen extends StatefulWidget {
  int index; //which Fact in the array is the user seeing (initially it's 0) when moving from the awareness main page
  int id; // module ID
  String name; //module name
  FactsScreen(
      {Key? key, required this.index, required this.id, required this.name})
      : super(key: key);

  @override
  State<FactsScreen> createState() => _FactsScreenState(index, id, name);
}

class _FactsScreenState extends State<FactsScreen> {
  int _factIndex = 0; //Fact index moved through the previous iteration
  _FactsScreenState(this._factIndex, this.id, this.name);
  List factsList = []; //List of facts related to module
  int size = 1; //Size of facts list
  int id; //module ID
  String name; //module name

/* 
On init, we fetch all the facts from the facts services page
*/
  @override
  void initState() {
    super.initState();
    fetchDatabaseList(id); //function that retrieves all module facts
  }

/* 
  This method moves the user to the next fact

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * index is increased by 1 and saved in the state causing the page to reload with new data from new index
  * if we get to the end the index is reset pending on what action does the user do
  
*/

  void _nextFact() {
    setState(() {
      _factIndex++;
    });
    if (_factIndex > size) {
      _resetFacts();
    }
  }

/* 
  This method moves the user to the previous fact

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * index is decrease by 1 causing the page to reload with new data from new index
  * if we get to the first index this function cannot be called anymore
  
*/

  void _prevFact() {
    setState(() {
      _factIndex = _factIndex - 1;
    });
  }

/* 
  This method resets the fact index to the start

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * index is set back to 0 and saved in the state
  
*/

  void _resetFacts() {
    setState(() {
      _factIndex = 0;
    });
  }

/* 
  This method calls the facts services page to retrieve facts related to this
  module

  Inputs:
  * id: module ID

  Outputs:
  * NO RETURN OUTPUT
  * List of facts is saved in the state
  * Size of list is saved in the state
  
*/
  Future fetchDatabaseList(id) async {
    dynamic resultant = await FactService().getUserTaskList(id); //retrieve data
    if (resultant == null) {
    } else {
      setState(() {
        resultant; //save the dynamic variable to state
        factsList = resultant; //save the list of facts to state
        size = factsList.length; //save the size of lists to state
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
          ), //navigates user to previous page
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) =>
                        const PageHolder())); //navigates user to home page
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              /*Retrieves facts from database */
              future: fetchDatabaseList(id),
              initialData: factsList,
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
                        //percent is based on which index are we in relation to the whole size of the list
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
                            factsList[_factIndex].awatitle,
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
                              //This widget is used to load data in HTML format to enable custom bolding of words creating links
                              data: (factsList[_factIndex].awatext),
                              onLinkTap: (url, _, __, ___) async {
                                //enables browser to open once link is clicked
                                if (await canLaunchUrlString(url!)) {
                                  await launchUrlString(
                                    url,
                                    mode: LaunchMode.inAppWebView,
                                  );
                                }
                              },
                              //CSS like styling to tags
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
                              factsList[_factIndex].awaimg,
                              width: double.infinity,
                            ),
                          )),
                      Container(height: 40),
                      ListTile(
                        title: Row(children: <Widget>[
                          Expanded(
                              child: GestureDetector(
                                  //if we are not on first index, show previous button
                                  //on click navigate to previous fact by doing index--
                                  onTap: () {
                                    if (_factIndex > 0) {
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
                                      ? const FittedBox(
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
                                      : const FittedBox(
                                          fit: BoxFit.fitHeight))),
                          Expanded(
                            child: GestureDetector(
                              //if we are not on last index, show next button
                              //on click navigate to previous fact by doing index++
                              onTap: () {
                                if (_factIndex < size - 1) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => FactsScreen(
                                            index: _factIndex,
                                            id: id,
                                            name: name,
                                          )));
                                  _nextFact();
                                } else {
                                  //else show go to quiz button
                                  //reset index and navigate to quiz page
                                  _resetFacts();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => QuizScreen(
                                            id: id,
                                            name: name,
                                          )));
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
