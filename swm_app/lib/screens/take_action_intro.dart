import 'package:flutter/material.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/take_actions.dart';

/* 
  This screen is the introduction screen to the actions section 
  that shows a quick interesting fact about the module which hopefully 
  intrigues the user to dive deeper in the subject
  
  id and name params are passed through this page to other pages down the line
  to skip having to call the database just to retrieve the name of a module
*/

class ActionIntro extends StatelessWidget {
  int id; //module id
  String name; //module name
  ActionIntro({Key? key, required this.id, required this.name})
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
          ), //navigate to previous page
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageHolder()));
              }, //navigate to home page
            )
          ],
        ),
        body: Stack(
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TakeAction(id: id)));
                }, //takes you to main actions page
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/takeaction$id.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ],
        ));
  }
}
