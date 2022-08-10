import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/Components/answer.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/quiz_finished.dart';
import 'package:swm_app/services/quiz_services.dart';

/* 
  This screen is where the users conduct the quiz about a module
  
*/
class QuizScreen extends StatefulWidget {
  int id; //module id
  String name; //module name
  QuizScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(id, name);
}

class _QuizScreenState extends State<QuizScreen> {
  // definition of variables
  int questionIndex =
      0; //index of the questions, important to track progress and load new questions
  bool answerScore = false; //defines wether selected answer is right or wrong
  int totalScore = 0; // tracks the score
  bool endOfQuiz = false; //helps to define what happens at the end of the quiz
  String QuizRefID = ""; //reference ID of the quiz
  List QuizData = []; //list where data from Firestore is stored
  int size = 1; //size of list of quiz data
  int quizPoints = 0; //number of points achieved if pass
  int id; //module id
  String name; //module name
  _QuizScreenState(this.id, this.name);

/* 
  This method defines what happens when answer was selected

  Inputs:
  * answerResult: was the answer correct or not

  Outputs:
  * NO RETURN OUTPUT
  * if correct add 1 point. 
  *if this is the end of the quiz turn end flag to true
  
*/

  void _questionAnswered(bool answerResult) {
    setState(() {
      if (answerResult) {
        totalScore++;
      }
      // when the quiz ends
      if (questionIndex + 1 == QuizData.length) {
        endOfQuiz = true;
      }
    });
  }

  /* 
  This method describes what happens when you click on next question button

  Inputs:
  NO INPUT

  Outputs:
  * increment index checking array indices by 1
  
*/
  void _nextQuestions() {
    setState(() {
      questionIndex++;
    });
  }

  /* 
  This method describes what happens at the end of the quiz

  Inputs:
  NO INPUT

  Outputs:
  * increment index checking array indices by 1
  
*/
  void _resetQuiz() {
    setState(() {
      questionIndex = 0; //index checking indices is back to 0
      totalScore = 0; //score is back to 0
      endOfQuiz = false; //end flag is false again
    });
  }

  /* 
  This method loads the quiz data of a certain module

  Inputs:
  *id: quiz id

  Outputs:
  * NO RETURN OUTPUT
  *quiz data is saved in a list which is saved in the state
  *size of that list is also saved in the state
  
*/
  Future loadQuizData(id) async {
    //retrieve data from quiz services
    dynamic resultant = await QuizService().getQuizList(id);
    if (resultant == null) {
      print('Unable to retrieve for some reason');
    } else {
      setState(() {
        QuizData = resultant; // List of quiz data
        size = QuizData.length; //size of the list
      });
      QuizRefID =
          QuizData[0].parentID; //reference id of the quiz entry in firebase
      quizPoints = QuizData[0].points; //points gained if passed
    }
  }

  // on init, data is retrieved from firebase
  @override
  void initState() {
    super.initState();
    loadQuizData(id);
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
        body: Center(
          child: FutureBuilder(
              future: loadQuizData(id),
              initialData: QuizData,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return const Center(child: Text('Loading...'));
                }
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // displays progress dependent on the questions stored in the database
                      LinearPercentIndicator(
                        animateFromLastPercent: true,
                        animationDuration: 5000,
                        barRadius: const Radius.circular(16),
                        lineHeight: 20,
                        percent: (questionIndex + 1) / size,
                        backgroundColor:
                            const Color.fromARGB(255, 224, 223, 223),
                        progressColor: const Color.fromARGB(255, 11, 88, 151),
                      ),
                      const SizedBox(height: 20.0),
                      // Displays the questions
                      Container(
                        width: double.infinity,
                        height: 180.0,
                        margin: const EdgeInsets.only(
                            bottom: 10.0, left: 30.0, right: 30.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50.0, vertical: 20.0),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 11, 88, 151),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            QuizData[questionIndex].question,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // displaying the answers: the answers are mapped to return Answer() widget with given parameters from Components.
                      ...(QuizData[questionIndex].answers).map(
                        (answer) => Answer(
                          answerText: answer,
                          // here it is defined what happens with the selcted answer
                          answerTap: () {
                            //checks whether selected answer is right or wrong
                            answer == QuizData[questionIndex].correct
                                ? answerScore = true
                                : answerScore = false;
                            // calls function to add to score and check whether quiz is at the end or not
                            _questionAnswered(answerScore);
                            // displays whether the selcted answer was right or wrong, provides the explanation and the button to move to the next question or finish the quiz
                            showModalBottomSheet(
                                context: context,
                                isDismissible: false,
                                enableDrag: false,
                                backgroundColor: Colors.transparent,
                                builder: (context) => Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.53,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 232, 232, 232),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25),
                                          topRight: Radius.circular(25),
                                        )),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const SizedBox(height: 20),
                                          // Displaying text whether answer was right or wrong
                                          Text(
                                            answerScore
                                                ? 'Right answer'
                                                : 'Wrong answer',
                                            style: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 113, 130, 137)),
                                          ),
                                          const SizedBox(height: 20),
                                          // Displaying icon whether answer was right or wrong
                                          Icon(
                                            answerScore
                                                ? Icons.thumb_up_alt
                                                : Icons.thumb_down_alt,
                                            color: answerScore
                                                ? const Color.fromARGB(
                                                    255, 75, 113, 76)
                                                : const Color.fromARGB(
                                                    255, 137, 46, 46),
                                          ),
                                          const SizedBox(height: 20),
                                          // displaying the explanation
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 35, right: 35),
                                            child: Text(
                                              QuizData[questionIndex]
                                                  .explanation,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic,
                                                  color: Color.fromARGB(
                                                      255, 70, 70, 70)),
                                            ),
                                          ),
                                          // defines button to jump to next question
                                          if (!endOfQuiz)
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: ElevatedButton.icon(
                                                    onPressed: () {
                                                      if (questionIndex <
                                                          size) {
                                                        _nextQuestions();
                                                      }
                                                      Navigator.pop(context);
                                                    },
                                                    icon: const Icon(Icons
                                                        .navigate_next_rounded),
                                                    label: const Text(
                                                      "Next Question",
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.grey,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          // defines button to jump to finish the quiz
                                          if (endOfQuiz)
                                            Expanded(
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: ElevatedButton.icon(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                              MaterialPageRoute(
                                                        builder: (context) =>
                                                            QuizFinish(
                                                                id: id,
                                                                name: name,
                                                                totalScore:
                                                                    totalScore,
                                                                possibleScore:
                                                                    QuizData
                                                                        .length,
                                                                quizRefID:
                                                                    QuizRefID,
                                                                quizPoints:
                                                                    quizPoints),
                                                      ));
                                                      if (questionIndex <
                                                          size) {
                                                        questionIndex--;
                                                        _nextQuestions();
                                                      }
                                                    },
                                                    icon: const Icon(
                                                        Icons.flag_outlined),
                                                    label: const Text(
                                                      "Finish Quiz",
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      primary: Colors.grey,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ])));
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
