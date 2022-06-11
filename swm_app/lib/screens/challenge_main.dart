import 'package:flutter/material.dart';
import 'package:swm_app/screens/awareness_main.dart';
import 'package:swm_app/screens/take_actions.dart';

class ChallengeMain extends StatelessWidget {
  const ChallengeMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Food Waste Challenge',
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black26),
              ),
              const SizedBox(height: 6),
              Material(
                color: Colors.blue,
                elevation: 8,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AwarenessMain(id: 1)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const NetworkImage(
                            "https://picsum.photos/250?image=9"),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        child: const Center(
                          child: Text(
                            "Awareness",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text('Learn more about the impact of Food Waste'),
              SizedBox(height: 14),
              Material(
                color: Colors.blue,
                elevation: 8,
                borderRadius: BorderRadius.circular(28),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: InkWell(
                  splashColor: Colors.black26,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TakeAction(id: 1)));
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Ink.image(
                        image: const NetworkImage(
                            "https://picsum.photos/250?image=9"),
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                        child: const Center(
                          child: Text(
                            "Take Action",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text('Explore Ways'),
            ]),
      ),
    );
  }
}
