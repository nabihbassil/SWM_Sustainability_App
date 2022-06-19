import 'package:flutter/material.dart';
import 'package:swm_app/screens/take_actions.dart';

class ActionIntro extends StatelessWidget {
  int id;
  String name;
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
          ),
        ),
        body: new Stack(
          children: <Widget>[
            new Container(
                child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => TakeAction(id: id)));
                    },
                    child: Container(
                      decoration: new BoxDecoration(
                        image: new DecorationImage(
                          image: new AssetImage("assets/takeaction$id.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ))),
          ],
        ));
  }
}
