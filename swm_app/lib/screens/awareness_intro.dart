import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/take_actions.dart';

class AwarenessIntro extends StatefulWidget {
  const AwarenessIntro({Key? key}) : super(key: key);

  @override
  _AwarenessIntroState createState() => _AwarenessIntroState();
}

class _AwarenessIntroState extends State<AwarenessIntro> {
  @override
  void initState() {
    super.initState();
  }

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
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: new NetworkImage(
                      "https://images.pexels.com/photos/7262910/pexels-photo-7262910.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 350,
                width: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(350, 350),
                            // Foreground color
                            onPrimary: Color.fromARGB(255, 100, 188, 24),
                            // Background color
                            primary: Color.fromARGB(200, 255, 255, 255)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AwarenessMain(id: 1)));
                        },
                        child: ListTile(
                          title: Text(
                            "Food Waste Challenge\n",
                            style: const TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 60, 60, 60),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          subtitle: Text(
                            'Did you know...\n\nIn Germany, around 12 million tonnes of food waste are generated every year.That’s 75 kg per person! \n\n- Federal Ministry of Food and Argriculture (2022)\n\n\n\n TAP HERE TO CONTINUE  ➜\n',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 80, 80, 80),
                            ),
                          ),
                        ))
                  ]),
                ),
              ),
            )
          ],
        ));
  }
}
