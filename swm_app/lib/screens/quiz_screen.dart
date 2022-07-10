import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/Components/answer.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/quiz_finished.dart';
import 'package:swm_app/services/quiz_services.dart';

class QuizScreen extends StatefulWidget {
  int id;
  String name;
  QuizScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState(id, name);
}

class _QuizScreenState extends State<QuizScreen> {
  // definition of variables
  int _questionIndex =
      0; //index of the questions, important to track progress and load new questions
  bool answerScore = false; //defines wether selected answer is right or wrong
  int _totalScore = 0; // tracks the score
  bool endOfQuiz = false; //helps to define what happens at the end of the quiz

  List QuizData = []; //list where data from Firestore is stored

  int id;
  String name;
  _QuizScreenState(this.id, this.name);

  // function that defines what happens when answer was selected
  void _questionAnswered(bool answerscore) {
    setState(() {
      if (answerScore) {
        _totalScore++;
      }
      // when the quiz ends
      if (_questionIndex + 1 == QuizData.length) {
        endOfQuiz = true;
      }
    });
  }

  // function that describes what happens when you click on next question button
  void _nextQuestions() {
    setState(() {
      _questionIndex++;
    });
    // calls function to define what happens at the end of the quiz
    //if (_questionIndex >= QuizData.length) {
    //_resetQuiz();
    //}
  }

  // function that describes what happens at the end of the quiz
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      endOfQuiz = false;
    });
  }

  // getting data from firebase
  @override
  void initState() {
    super.initState();
    loadQuizData(id);
  }

  Future loadQuizData(id) async {
    dynamic resultant = await QuizService().getQuizList(id);
    if (resultant == null) {
      print('Unable to retrieve for some reason');
    } else {
      setState(() {
        QuizData = resultant;
      });
      print("QuizData $QuizData ");
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
      ),
      body: Center(
        child: Padding(
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
                percent: (_questionIndex + 1) / QuizData.length,
                backgroundColor: Color.fromARGB(255, 224, 223, 223),
                progressColor: Color.fromARGB(255, 11, 88, 151),
              ),
              SizedBox(height: 20.0),
              // Displays the questions
              Container(
                width: double.infinity,
                height: 180.0,
                margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 11, 88, 151),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    QuizData[_questionIndex].question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // displaying the answers: the answers are mapped to return Answer() widget with given parameters from Components.
              ...(QuizData[_questionIndex].answers).map(
                (answer) => Answer(
                  answerText: answer,
                  // here it is defined what happens with the selcted answer
                  answerTap: () {
                    //checks whether selected answer is right or wrong
                    answer == QuizData[_questionIndex].correct
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
                            height: MediaQuery.of(context).size.height * 0.53,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 232, 232, 232),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                )),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 20),
                                  // Displaying text whether answer was right or wrong
                                  Text(
                                    answerScore
                                        ? 'Right answer'
                                        : 'Wrong answer',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 113, 130, 137)),
                                  ),
                                  const SizedBox(height: 20),
                                  // Displaying icon whether answer was right or wrong
                                  Icon(
                                    answerScore
                                        ? Icons.thumb_up_alt
                                        : Icons.thumb_down_alt,
                                    color: answerScore
                                        ? Color.fromARGB(255, 75, 113, 76)
                                        : Color.fromARGB(255, 137, 46, 46),
                                    shadows: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  // displaying the explanation
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 35, right: 35),
                                    child: Text(
                                      QuizData[_questionIndex].explanation,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                          color:
                                              Color.fromARGB(255, 70, 70, 70)),
                                    ),
                                  ),
                                  // defines button to jump to next question
                                  if (!endOfQuiz)
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              _nextQuestions();
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                                Icons.navigate_next_rounded),
                                            label: Text(
                                              "Next Question",
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuizFinish(
                                                              id: id,
                                                              name: name,
                                                              totalScore:
                                                                  _totalScore,
                                                              possibleScore:
                                                                  QuizData
                                                                      .length)));
                                              _nextQuestions();
                                            },
                                            icon: Icon(Icons.flag_outlined),
                                            label: Text(
                                              "Finish Quiz",
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.grey,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
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
        ),
      ),
    );
  }
}
