import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_intro.dart';
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
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AwarenessIntro(id: id, name: name))),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      child: Text(
                    "Awareness",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontWeight: FontWeight.bold),
                  ))),
              const SizedBox(height: 20),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            FactsScreen(index: 0, id: id, name: name)));
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
                  padding: const EdgeInsets.only(left: 65, right: 65),
                  child: Text(
                    "Discover how $name is harming our planet.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 100, 100, 100),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => QuizScreen(id: id, name: name)));
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
                  padding: const EdgeInsets.only(left: 65, right: 65),
                  child: Text(
                    "Test your knowledge in $name!",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
