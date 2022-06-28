import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/Components/answer.dart';
import 'package:swm_app/screens/awareness_main.dart';

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
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool correctAnswerSelected = false;
  bool endOfQuiz = false;
  String chosenAnswer = "";
  int id;
  String name;
  _QuizScreenState(this.id, this.name);

  // function that checks wether answer was correct and ads to progress bar
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
      if (_questionIndex + 1 == _questions.length) {
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
    if (_questionIndex >= _questions.length) {
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LinearPercentIndicator(
                animateFromLastPercent: true,
                animationDuration: 5000,
                barRadius: const Radius.circular(16),
                lineHeight: 20,
                percent: (_questionIndex + 1) / _questions.length,
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
                    _questions[_questionIndex]['question'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // displaying the answers: question[questionIndex]['answers] points to question at given index and given key. this value is then mapped to return a list of type <String, Object>.map() takes a function which runs through each value of list and then returns an iterable.so, it returns Answer() widget with given parameters.
              ...(_questions[_questionIndex]['answers']
                      as List<Map<String, dynamic>>)
                  .map(
                (answer) => Answer(
                  answerText: answer['answerText'],
                  borderColor: answerWasSelected
                      ? answer['score']
                          ? Colors.green
                          : Colors.red
                      : Colors.white,
                  answerTap: () {
                    // if answer was already selected then nothing happens onTap
                    if (answerWasSelected) {
                      return;
                    }
                    //answer is being selected
                    _questionAnswered(answer['answerText'], answer['score']);
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
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        SizedBox(height: 5.0),
                        Text(
                          _questions[_questionIndex]['explanation'] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15.0,
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
                      (_totalScore / _questions.length) > 0.5
                          ? Text(
                              'Congratulations! Your final score is: ${_totalScore}/${_questions.length}. We will add 100 points to your personal wallet.',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            )
                          : Text(
                              'Sorry! Your final score is: ${_totalScore}/${_questions.length}. Please try again.',
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

// data set of questions
final _questions = const [
  {
    'question': 'How long is New Zealand’s Ninety Mile Beach?',
    'answers': [
      {'answerText': '88km, so 55 miles long.', 'score': true},
      {'answerText': '55km, so 34 miles long.', 'score': false},
      {'answerText': '90km, so 56 miles long.', 'score': false},
    ],
    'explanation':
        'The ninety mile beach is only 88km, so 55 miles long. It is classified as an official highway in New Zealand.',
  },
  {
    'question':
        'In which month does the German festival of Oktoberfest mostly take place?',
    'answers': [
      {'answerText': 'January', 'score': false},
      {'answerText': 'October', 'score': false},
      {'answerText': 'September', 'score': true},
    ],
    'explanation': 'TBD',
  },
  {
    'question': 'Who composed the music for Sonic the Hedgehog 3?',
    'answers': [
      {'answerText': 'Britney Spears', 'score': false},
      {'answerText': 'Timbaland', 'score': false},
      {'answerText': 'Michael Jackson', 'score': true},
    ],
    'explanation': 'TBD',
  },
  {
    'question': 'In Georgia (the state), it’s illegal to eat what with a fork?',
    'answers': [
      {'answerText': 'Hamburgers', 'score': false},
      {'answerText': 'Fried chicken', 'score': true},
      {'answerText': 'Pizza', 'score': false},
    ],
    'explanation': 'TBD',
  },
  {
    'question':
        'Which part of his body did musician Gene Simmons from Kiss insure for one million dollars?',
    'answers': [
      {'answerText': 'His tongue', 'score': true},
      {'answerText': 'His leg', 'score': false},
      {'answerText': 'His butt', 'score': false},
    ],
    'explanation': 'TBD',
  },
  {
    'question': 'In which country are Panama hats made?',
    'answers': [
      {'answerText': 'Ecuador', 'score': true},
      {'answerText': 'Panama (duh)', 'score': false},
      {'answerText': 'Portugal', 'score': false},
    ],
    'explanation': 'TBD',
  },
  {
    'question': 'From which country do French fries originate?',
    'answers': [
      {'answerText': 'Belgium', 'score': true},
      {'answerText': 'France (duh)', 'score': false},
      {'answerText': 'Switzerland', 'score': false},
    ],
    'explanation': 'TBD',
  },
  {
    'question': 'Which sea creature has three hearts?',
    'answers': [
      {'answerText': 'Great White Sharks', 'score': false},
      {'answerText': 'Killer Whales', 'score': false},
      {'answerText': 'The Octopus', 'score': true},
    ],
    'explanation': 'TBD',
  },
  {
    'question': 'Which European country eats the most chocolate per capita?',
    'answers': [
      {'answerText': 'Belgium', 'score': false},
      {'answerText': 'The Netherlands', 'score': false},
      {'answerText': 'Switzerland', 'score': true},
    ],
    'explanation': 'TBD',
  },
];
