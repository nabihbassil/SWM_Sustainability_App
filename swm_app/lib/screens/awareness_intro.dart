import 'package:flutter/material.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/challenge_main.dart';

class AwarenessIntro extends StatelessWidget {
/* 
  This screen is the introduction screen that shows a quick interesting fact
  about the module which hopefully intrigues the user to dive deeper in the 
  subject
  
  id and name params are passed through this page to other pages down the line
  to skip having to call the database just to retrieve the name of a module
*/

  int id; //module ID
  String name; //module name
  AwarenessIntro({Key? key, required this.id, required this.name})
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
                builder: (context) => ChallengeMain(id: id, name: name))),
          ), //takes you back to previous page
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageHolder()));
              }, //takes you back to home page
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AwarenessMain(id: id, name: name)));
                }, //takes you to next page
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/awareness$id.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ],
        ));
  }
}
