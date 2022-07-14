import 'package:flutter/material.dart';
import 'package:swm_app/screens/login_screen.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigatetologin();
  }

  _navigatetologin() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: ((context) => const LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
                child: Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 200,
                                child: Image.asset(
                                  'assets/SWM_logo.jpg',
                                  fit: BoxFit.contain,
                                )),
                            SizedBox(
                                height: 170,
                                child: Image.asset(
                                  'assets/earth.gif',
                                  fit: BoxFit.contain,
                                )),
                            const SizedBox(height: 63),
                            Container(
                                child: const Text(
                                    'Its just a few clicks towards \n more sustainability！',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color.fromARGB(255, 100, 100, 100),
                                        fontWeight: FontWeight.bold))),
                            const SizedBox(height: 10),
                          ]),
                    )))));
  }
}
