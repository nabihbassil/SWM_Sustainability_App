import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_intro.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/take_action_intro.dart';
import 'package:swm_app/screens/take_actions.dart';

// ignore: must_be_immutable
class ChallengeMain extends StatefulWidget {
  int id;
  String name;
  ChallengeMain({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ChallengeMain> createState() => _ChallengeMain(id, name);
}

class _ChallengeMain extends State<ChallengeMain> {
  int id;
  String name;
  _ChallengeMain(this.id, this.name);
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
                  padding: EdgeInsets.only(right: 90),
                  child: Text(
                    "$name Challenge",
                    style: TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AwarenessIntro()));
                  },
                  // change to navigation to awareness screen
                  child: SizedBox(
                      height: 140,
                      child: Image.asset(
                        'assets/awarenessicon.png',
                        fit: BoxFit.contain,
                      ))),
              const SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.only(left: 60, right: 60),
                  child: Text(
                    "Learn about the impact of $name and test your knowledge",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 100, 100, 100),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ActionIntro()));
                  },
                  // change to navigation to tasks screen
                  child: SizedBox(
                      height: 140,
                      child: Image.asset(
                        'assets/takeactionicon.png',
                        fit: BoxFit.contain,
                      ))),
              const SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.only(left: 60, right: 60),
                  child: Text(
                    "Explore ways you can reduce $name in your daily life",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 100, 100, 100),
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  )),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
