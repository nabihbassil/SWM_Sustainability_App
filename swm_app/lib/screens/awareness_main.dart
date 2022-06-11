import 'package:flutter/material.dart';
import 'package:swm_app/Components/hamburger_menu.dart';

class AwarenessMain extends StatelessWidget {
  const AwarenessMain({Key? key, required int id}) : super(key: key);

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
      drawer: const HamburgerMenu(),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    // Background color
                    primary: Colors.lightBlueAccent,
                    fixedSize: const Size(240, 80)),
                child: Center(
                  child: Column(children: [
                    Icon(
                      Icons.book,
                      color: Colors.black,
                      size: 50,
                    ),
                    Text(
                      'Learn Facts',
                      style: TextStyle(color: Colors.blue),
                    )
                  ]),
                ),
              ),
              SizedBox(height: 14),
              Text('Discover how Food Waste is Warming our Planet'),
              SizedBox(height: 34),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    // Background color
                    primary: Colors.lightGreenAccent,
                    fixedSize: const Size(240, 80)),
                child: Center(
                  child: Column(children: [
                    Icon(
                      Icons.question_mark,
                      color: Colors.black,
                      size: 50,
                    ),
                    Text(
                      'Take A Quiz',
                      style: TextStyle(color: Colors.green),
                    )
                  ]),
                ),
              ),
              SizedBox(height: 14),
              Text('Test your Knowledge'),
            ]),
      ),
    );
  }
}
