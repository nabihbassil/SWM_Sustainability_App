import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/Components/answer.dart';
import 'package:swm_app/screens/awareness_main.dart';
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
  // definition of variables to track progess
  int _questionIndex = 0;
  bool answerScore = false;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool correctAnswerSelected = false;
  bool endOfQuiz = false;
  String chosenAnswer = "";
  int id;
  String name;
  List QuizData = [];
  int size = 0;

  _QuizScreenState(this.id, this.name);

  // function that checks wether answer was correct
  void _questionAnswered(String answerText, bool answerScore) {
    setState(() {
      //answer was selected
      answerWasSelected = true;
      chosenAnswer = answerText;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
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
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    if (_questionIndex >= QuizData.length) {
      _resetQuiz();
    }
  }

  // function that describes what happens at the end of the quiz
  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      endOfQuiz = false;
    });
  }

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
      print("size $size ");
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                height: 130.0,
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
                      fontSize: 15.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // displaying the answers: question[questionIndex]['answers] points to question at given index and given key. this value is then mapped to return a list of type <String, Object>.map() takes a function which runs through each value of list and then returns an iterable.so, it returns Answer() widget with given parameters.
              ...(QuizData[_questionIndex].answers).map(
                (answer) => Answer(
                  answerText: answer,
                  borderColor: Colors.green,
                  /*borderColor: answerWasSelected
                      ? answer['score']
                          ? Colors.green
                          : Colors.red
                      : Colors.white,*/
                  answerTap: () {
                    // if answer was already selected then nothing happens onTap
                    if (answerWasSelected) {
                      return;
                    }
                    //answer is being selected
                    if (answer == QuizData[_questionIndex].correct) {
                      answerScore = true;
                    }
                    _questionAnswered(answer, answerScore);
                  },
                ),
              ),
              SizedBox(height: 20.0),

              if (answerWasSelected && !endOfQuiz)
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      children: [
                        correctAnswerSelected
                            ? Icon(Icons.check_circle, color: Colors.green)
                            : Icon(Icons.clear, color: Colors.red),
                        SizedBox(height: 10.0),
                        Text(
                          correctAnswerSelected
                              ? 'Well done, "${chosenAnswer}" is the right answer.'
                              : 'You are wrong, "${chosenAnswer}" is not the right answer.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 2.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          QuizData[_questionIndex].explanation,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 2.0,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          onPressed: () {
                            if (!answerWasSelected) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                    'Please select an answer before going to the next question'),
                              ));
                              return;
                            }
                            _nextQuestions();
                          },
                          child: Text(
                              endOfQuiz ? 'Restart Quiz' : 'Next Question'),
                        ),
                      ],
                    ),
                  ),
                ),

              if (endOfQuiz)
                Container(
                  height: 200,
                  width: double.infinity,
                  child: Center(
                      child: Column(
                    children: [
                      (_totalScore / QuizData.length) > 0.5
                          ? Text(
                              'Congratulations! Your final score is: ${_totalScore}/${QuizData.length}. We will add 100 points to your personal wallet.',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            )
                          : Text(
                              'Sorry! Your final score is: ${_totalScore}/${QuizData.length}. Please try again.',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            )
                    ],
                  )),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
