import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/services/user_service.dart';

class QuizFinish extends StatefulWidget {
  int id;
  String name, quizRefID;
  // totalScore and possibleScore will be passed from QuizScreen
  int totalScore;
  int possibleScore;
  int quizPoints;

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
  // totalScore and possibleScore will be passed from QuizScreen
  int totalScore = 0;
  int possibleScore = 0;
  int quizPoints = 0;
  _QuizFinishState(this.id, this.name, this.totalScore, this.possibleScore,
      this.quizRefID, this.quizPoints);

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    UpdateQuizDone();
  }

  UpdateQuizDone() async {
    bool isQuizDoneBeforeUpdate; // use this to choose which text to print
    int notDoneLength = -1;
    List LTasks = ['0'];
    isQuizDoneBeforeUpdate = await UserService().IsQuizAlreadyDone(quizRefID);

    if (!isQuizDoneBeforeUpdate) {
      UserService().UpdateQuizDone(quizRefID);

      await UserService().GetAllActionDone().then((value) => LTasks = value);

      notDoneLength = await UserService().GetSizeofToDoTasks(id, LTasks);

      UserService().updateModuleLogic(id, true, notDoneLength);
      UserService().UpdatePoints(quizPoints);
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
                "You will get $quizPoints points for your personal wallet",
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
