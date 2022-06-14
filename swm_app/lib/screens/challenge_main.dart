import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/take_actions.dart';

class ChallengeMain extends StatelessWidget {
  const ChallengeMain({Key? key}) : super(key: key);

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
                        print('navigate back to challenges selection menu');
                        // place holder for navigation
                      })),
              Padding(
                  padding: EdgeInsets.only(right: 90),
                  child: Text(
                    "Food Waste Challenge",
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
                            builder: (context) => const AwarenessMain(
                                  id: 1,
                                )));
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
                    "Learn about the impact of Food Waste and test your knowledge",
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
                            builder: (context) => const TakeAction(
                                  id: 1,
                                )));
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
                    "Explore ways you can reduce food waste in your daily life",
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
