import 'package:flutter/material.dart';
import 'package:swm_app/Components/hamburger_menu.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/screens/facts_screen.dart';
import 'package:swm_app/screens/quiz_screen.dart';

class AwarenessMain extends StatelessWidget {
  const AwarenessMain({Key? key, required int id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 315),
                  child: TextButton(
                      child: const Text("< Back",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 13,
                              color: Color.fromARGB(255, 150, 150, 150),
                              fontWeight: FontWeight.bold)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      })),
              Padding(
                  padding: EdgeInsets.only(right: 220),
                  child: Text(
                    "Awareness",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FactsScreen()));
                  },
                  // change to navigation to awareness screen
                  child: SizedBox(
                      height: 150,
                      child: Image.asset(
                        'assets/learnfactsicon.png',
                        fit: BoxFit.contain,
                      ))),
              const SizedBox(height: 7),
              Padding(
                  padding: EdgeInsets.only(left: 65, right: 65),
                  child: Text(
                    "Discover how Food Waste is harming our planet.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 100, 100, 100),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => QuizScreen()));
                  },
                  // change to navigation to tasks screen
                  child: SizedBox(
                      height: 150,
                      child: Image.asset(
                        'assets/takequizicon.png',
                        fit: BoxFit.contain,
                      ))),
              const SizedBox(height: 7),
              Padding(
                  padding: EdgeInsets.only(left: 65, right: 65),
                  child: Text(
                    "Test your knowledge in Food Waste! (You can only take the quiz after reading the facts once!)",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 100, 100, 100),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 42),
            ],
          ),
        ),
      ),
    );
  }
}
