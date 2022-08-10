import 'package:flutter/material.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/awareness_intro.dart';
import 'package:swm_app/screens/take_action_intro.dart';

/* 
  This screen is the transfer page where you choose between learning theoretical
  information about a subject or practical actions you can do in your daily life
  to be sustainable in a certain topic.
  
  id and name params are passed through this page to other pages down the line
  to skip having to call the database just to retrieve the name of a module
*/
class ChallengeMain extends StatefulWidget {
  int id; //module ID
  String name; //module name
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
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => PageHolder())),
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 30),
              Align(
                  alignment: Alignment.center,
                  child: Container(
                      child: Text(
                    "$name Challenge",
                    style: const TextStyle(
                        fontSize: 24,
                        color: Color.fromARGB(255, 70, 70, 70),
                        fontWeight: FontWeight.bold),
                  ))),
              const SizedBox(height: 40),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AwarenessIntro(id: id, name: name)));
                  },
                  /* Navigates user to the awareness (theoretical) section */
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
                  /* Navigates user to the action (practical) section */
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
                    "Explore ways you can reduce the negative impacts of $name in your daily life",
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
