import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/challenge_main.dart';

class QuizFinish extends StatefulWidget {
  int id;
  String name;
  // totalScore and possibleScore will be passed from QuizScreen
  int totalScore;
  int possibleScore;

  QuizFinish(
      {Key? key,
      required this.id,
      required this.name,
      required this.totalScore,
      required this.possibleScore})
      : super(key: key);

  @override
  _QuizFinishState createState() => _QuizFinishState();
}

class _QuizFinishState extends State<QuizFinish> {
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
              builder: (context) =>
                  ChallengeMain(id: widget.id, name: widget.name))),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: Text(
                "Congratulations on completing the quiz",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 30),
              Icon(
                Icons.verified_user,
                size: 60.0,
                color: Color.fromARGB(255, 75, 113, 76),
                shadows: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Center(
                  child: Text(
                "Your final score is \n${widget.totalScore} / ${widget.possibleScore}",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 40),
              Center(
                  child: Text(
                "You will get 250 points for your personal wallet",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          ChallengeMain(id: widget.id, name: widget.name)));
                },
                icon: Icon(Icons.school),
                label: Text(
                  "Back to Challenge Overview",
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
