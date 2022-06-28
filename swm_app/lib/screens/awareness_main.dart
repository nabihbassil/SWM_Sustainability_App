import 'package:flutter/material.dart';
import 'package:swm_app/Components/hamburger_menu.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/screens/facts_screen.dart';
import 'package:swm_app/screens/quiz_screen.dart';

class AwarenessMain extends StatelessWidget {
  String name;
  int id;
  AwarenessMain({Key? key, required this.id, required this.name})
      : super(key: key);

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
          padding: const EdgeInsets.all(1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FactsScreen(index: 1, id: id)));
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
                    "Discover how $name is harming our planet.",
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizScreen(id: id)));
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
                    "Test your knowledge in $name!",
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
