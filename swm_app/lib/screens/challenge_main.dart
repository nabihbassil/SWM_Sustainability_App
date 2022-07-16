import 'package:flutter/material.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/awareness_intro.dart';
import 'package:swm_app/screens/challenge_screen.dart';
import 'package:swm_app/screens/take_action_intro.dart';

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PageHolder()));
            },
          )
        ],
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
                    "$name Challenge",
                    style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontWeight: FontWeight.bold),
                  ))),
              const SizedBox(height: 30),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AwarenessIntro(id: id, name: name)));
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
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    "Learn about the impact of $name and test your knowledge",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
                            builder: (context) =>
                                ActionIntro(id: id, name: name)));
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
                  padding: const EdgeInsets.only(left: 40, right: 40),
                  child: Text(
                    "Explore ways you can reduce $name in your daily life",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
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
