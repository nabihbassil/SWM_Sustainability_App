import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class Badges extends StatefulWidget {
  const Badges({Key? key}) : super(key: key);

  @override
  State<Badges> createState() => _BadgesState();
}

class _BadgesState extends State<Badges> {
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
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Badge Collection",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 70, 70, 70)),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(right: 290),
                        child: Text(
                          "General",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 130, 130, 130)),
                        )),
                    const SizedBox(height: 15),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      crossAxisCount: 4,
                      children: <Widget>[
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 195, 195, 195),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Padding(
                        padding: EdgeInsets.only(right: 240),
                        child: Text(
                          "Consumption",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 130, 130, 130)),
                        )),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      crossAxisCount: 4,
                      children: <Widget>[
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 195, 195, 195),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 195, 195, 195),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Padding(
                        padding: EdgeInsets.only(right: 290),
                        child: Text(
                          "Energy",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 130, 130, 130)),
                        )),
                    const SizedBox(height: 15),
                    GridView.count(
                      primary: false,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      crossAxisSpacing: 30,
                      mainAxisSpacing: 30,
                      crossAxisCount: 4,
                      children: <Widget>[
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 195, 195, 195),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 195, 195, 195),
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                            width: 10.0,
                            height: 10.0,
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 195, 195, 195),
                              shape: BoxShape.circle,
                            )),
                        Container(
                          width: 10.0,
                          height: 10.0,
                          decoration: new BoxDecoration(
                            color: Color.fromARGB(255, 195, 195, 195),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ])))
            ],
          ),
        ),
      ),
    );
  }
}
