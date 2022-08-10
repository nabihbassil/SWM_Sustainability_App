// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/screens/success_module.dart';
import 'package:swm_app/services/user_service.dart';

/*
This interface is displayed once the user has finished the quiz. Here he can see
his score on the quiz and if he passed or not
*/
class QuizFinish extends StatefulWidget {
  int id; //module ID
  String name, quizRefID; //module name, reference ID of the quiz
  int totalScore; //number of questions the user got right
  int possibleScore; //number of available questions
  int quizPoints; //points awarded if passed

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
  int id = 0; //module ID
  String name = ""; //module name
  String quizRefID = ""; //reference ID of the quiz
  int totalScore = 0; //number of questions the user got right
  int possibleScore = 0; //number of available questions
  int quizPoints = 0; //points awarded if passed
  bool finished = false; //has user passed or not

  _QuizFinishState(this.id, this.name, this.totalScore, this.possibleScore,
      this.quizRefID, this.quizPoints);

  bool wasQuizDoneBeforeUpdate =
      false; //this variable declaration is used to identify, if quiz has already been completed previously

/* 
  This method checks wether quiz was done before and if not, update backend with new info

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * If quiz was not done before and now passed add points to tally and quiz id to list
    of completed quizzes
  
*/
  UpdateQuizDone() async {
    int notDoneLength = -1; //number of actions not done
    List tasksList = ['0']; //Lists of IDs of actions done

    //check if the quiz was done already or not
    wasQuizDoneBeforeUpdate = await UserService().IsQuizAlreadyDone(quizRefID);

    if (!wasQuizDoneBeforeUpdate) {
      //quiz not done

      //adds ID to user list of quizzes done
      UserService().UpdateQuizDone(quizRefID);

      //gets the list of actions done to see if the whole module is done
      await UserService().GetAllActionDone().then((value) => tasksList = value);
      //gets number of actions not done. 0 = all actions have been done
      notDoneLength = await UserService().GetSizeofToDoTasks(id, tasksList);

      //check if the whole module has been finished (complete quiz and all actions)
      bool finished =
          await UserService().updateModuleLogic(id, true, notDoneLength);

      if (finished == true) {
        //module is finished, wait one second and navigate to congrats page
        var future = new Future.delayed(
            const Duration(seconds: 1),
            (() => Navigator.push(context,
                MaterialPageRoute(builder: (context) => Success(id: id)))));
      }

      //update user point tally with new points from quiz
      UserService().UpdatePoints(quizPoints);
    }

    setState(() {
      wasQuizDoneBeforeUpdate;
    });
  }

/*
on init, a function is called to check if points should be added based on different
criteria: passing and newly accomplished quiz
 */
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    UpdateQuizDone();
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
        ), //navigate to main awareness page
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
                }, //navigate to main awareness page
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
