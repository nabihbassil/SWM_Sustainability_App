// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/screens/success_module.dart';
import 'package:swm_app/services/user_service.dart';

class QuizFinish extends StatefulWidget {
  int id;
  String name, quizRefID;
  int totalScore;
  int possibleScore;
  int quizPoints;

  // all of this will be passed from quiz_screen
  QuizFinish(
      {Key? key,
      required this.id,
      required this.name,
      required this.totalScore,
      required this.possibleScore,
      required this.quizRefID,
      required this.quizPoints})
      : super(key: key);

  @override
  _QuizFinishState createState() => _QuizFinishState(
      id, name, totalScore, possibleScore, quizRefID, quizPoints);
}

class _QuizFinishState extends State<QuizFinish> {
  int id = 0;
  String name = "";
  String quizRefID = "";
  int totalScore = 0;
  int possibleScore = 0;
  int quizPoints = 0;

  _QuizFinishState(this.id, this.name, this.totalScore, this.possibleScore,
      this.quizRefID, this.quizPoints);

  bool wasQuizDoneBeforeUpdate =
      false; //this variable declaration is used to identify, if quiz has already been completed

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    UpdateQuizDone();
  }

  // check wether quiz was done before and if not, update backend incl. points
  UpdateQuizDone() async {
    int notDoneLength = -1;
    List LTasks = ['0'];
    bool finished = false;
    wasQuizDoneBeforeUpdate = await UserService().IsQuizAlreadyDone(quizRefID);

    if (!wasQuizDoneBeforeUpdate) {
      UserService().UpdateQuizDone(quizRefID);

      await UserService().GetAllActionDone().then((value) => LTasks = value);

      notDoneLength = await UserService().GetSizeofToDoTasks(id, LTasks);

      bool finished =
          await UserService().updateModuleLogic(id, true, notDoneLength);

      UserService().UpdatePoints(quizPoints);
    }
    setState(() {
      wasQuizDoneBeforeUpdate;
    });

    if (finished) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => Success(id: id)));
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
              builder: (context) => ChallengeMain(id: id, name: name))),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Congratulations for completing quiz and icon for better look and feel
              const Center(
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
              const Icon(
                Icons.verified_user,
                size: 60.0,
                color: Color.fromARGB(255, 75, 113, 76),
              ),
              const SizedBox(height: 30),
              // quiz performance
              Center(
                  child: Text(
                "Your final score is \n$totalScore / $possibleScore",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 40),
              // Either show user that points will be added or show that quiz has already been completed
              Center(
                  child: Text(
                wasQuizDoneBeforeUpdate
                    ? "Note: You have already completed the quiz and received $quizPoints points for this"
                    : "You will get $quizPoints points for your personal wallet",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 100, 100, 100),
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              )),
              const SizedBox(height: 40),
              // button to move back to challenge overview
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ChallengeMain(id: id, name: name)));
                },
                icon: const Icon(Icons.school),
                label: const Text(
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
