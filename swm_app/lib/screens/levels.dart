import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Levels extends StatefulWidget {
  const Levels({Key? key}) : super(key: key);

  @override
  State<Levels> createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 232, 243, 228),
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
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Levels Overview",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 45, 75, 40),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Container(
                    width: 340.00,
                    height: 30.00,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: ExactAssetImage('assets/comillas.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
                Container(
                    width: 340,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Text(
                      'Our points reflects the knowledge you have gained for a better understanding of sustainability as well as your individual actions towards a more sustainable lifestyle.\n\n Your points are accumulated and help you to reach certain levels. For each you level you receive an award. Scroll down to see what each level might offer.       ',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 98, 119, 95),
                      ),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    width: 340.00,
                    height: 30.00,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: ExactAssetImage('assets/comillas2.png'),
                        fit: BoxFit.fitWidth,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
