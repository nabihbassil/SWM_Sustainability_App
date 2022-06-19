import 'package:flutter/material.dart';
import 'package:swm_app/screens/take_actions.dart';

class ActionIntro extends StatefulWidget {
  const ActionIntro({Key? key}) : super(key: key);

  @override
  _ActionIntroState createState() => _ActionIntroState();
}

class _ActionIntroState extends State<ActionIntro> {
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
                      "https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            new Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                height: 300,
                width: 350,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(300, 300),
                            // Foreground color
                            onPrimary: Color.fromARGB(255, 100, 188, 24),
                            // Background color
                            primary: Color.fromARGB(200, 255, 255, 255)),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => TakeAction(id: 1)));
                        },
                        child: ListTile(
                          title: Text(
                            "Take Action\n",
                            style: const TextStyle(
                              fontSize: 23,
                              color: Color.fromARGB(255, 60, 60, 60),
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          subtitle: Text(
                            'Very great change starts from very small conversations, held among people who care \n - Margaret J. Weatley \n\n Learn about ways you can take action in your daily life! \n\n\n TAP HERE TO CONTINUE  ➜',
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
