import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:swm_app/Components/singlearticle.dart';
import 'package:swm_app/model/news_model.dart';
import 'package:swm_app/model/user_model.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/screens/levels.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/services/user_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Query _level = FirebaseFirestore.instance.collection('Levels');
  List<Object> _newsList = [];

  int points = 0;
  int level = 1;
  int leveltotal = 1000;

  List LProgress = ['0'];
  UserModel userData = UserModel();

  fetchUserData() async {
    userData = await UserService().getUserData();

    setState(() {
      userData;
      points = userData.points!;
    });
  }

  getLevel() {}

  GetAllModulesInProgress() async {
    await UserService()
        .GetAllModulesInProgress()
        .then((value) => LProgress = value);
    print("print progreesss $LProgress");
    if (mounted) {
      setState(() {
        LProgress;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getNewsList();
    fetchUserData();
    GetAllModulesInProgress();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      "Current Challenges",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 99, 99, 99),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 120,
                  child: FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('modules')
                          .where("modID", whereIn: LProgress)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Loading...'));
                        }
                        return Expanded(
                            child: ListView(
                          shrinkWrap: false,
                          scrollDirection: Axis.horizontal,
                          children: snapshot.data!.docs.map((item) {
                            return Row(children: [
                              Column(
                                children: [
                                  Row(children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: SizedBox(
                                        child: Text(
                                          item['modName'],
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color: Color.fromARGB(
                                                  255, 131, 131, 131),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          150,
                                    )
                                  ]),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ChallengeMain(
                                                    id: item['modID'],
                                                    name: item['modName'],
                                                  )));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 90,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              item['modIMG'],
                                              fit: BoxFit.cover,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40,
                                            ),
                                            Positioned(
                                              top: 10,
                                              left: 10,
                                              child: Text(
                                                item['category']
                                                    .replaceAll("\\n", "\n"),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    color: Color.fromARGB(
                                                        255, 255, 255, 255),
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FontStyle.italic),
                                                textAlign: TextAlign.left,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ]);
                          }).toList(),
                        ));
                      })),
              const SizedBox(height: 7),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      "Latest Articles",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 99, 99, 99),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  child: Expanded(
                      child: ListView.builder(
                    shrinkWrap: false,
                    scrollDirection: Axis.horizontal,
                    itemCount: _newsList.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(_newsList[index] as Article);
                    },
                  ))),
              const SizedBox(height: 10),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: const Text(
                      "Your Level",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 99, 99, 99),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              const SizedBox(height: 15),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Levels()));
                  },
                  // change to navigation to awareness screen
                  child: SizedBox(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Center(
                          child: Stack(
                              clipBehavior: Clip.none,
                              alignment: Alignment.center,
                              children: <Widget>[
                            Container(
                                height: 90,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(255, 224, 239, 242),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))),
                            Positioned(
                              bottom: 95,
                              child: Container(
                                  height: 10,
                                  width:
                                      MediaQuery.of(context).size.width * 0.88,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 224, 239, 242),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20)))),
                            ),
                            const Positioned(
                              bottom: 40,
                              child: SizedBox(
                                height: 75,
                                child: Image(
                                  image: AssetImage('assets/levelicon.png'),
                                ),
                              ),
                            ),
                            Positioned(
                                top: 35,
                                left: 15,
                                child: Text(
                                  "Level " + level.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 85, 148, 75),
                                      fontWeight: FontWeight.bold),
                                )),
                            Positioned(
                                bottom: 67,
                                child: Text(level.toString(),
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.arvo(
                                      textStyle: const TextStyle(
                                          fontSize: 32,
                                          color:
                                              Color.fromARGB(255, 208, 166, 15),
                                          fontWeight: FontWeight.bold),
                                    ))),
                            const Positioned(
                                top: 8,
                                right: 15,
                                child: Text(
                                  "+",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color.fromARGB(255, 106, 144, 161),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Positioned(
                                bottom: 22,
                                left: 5,
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.86,
                                  child: LinearPercentIndicator(
                                    animateFromLastPercent: true,
                                    animationDuration: 5000,
                                    barRadius: const Radius.circular(16.0),
                                    lineHeight: 10,
                                    percent: points / leveltotal,
                                    backgroundColor: const Color.fromARGB(
                                        255, 167, 196, 161),
                                    progressColor:
                                        const Color.fromARGB(255, 23, 141, 4),
                                  ),
                                )),
                            Positioned(
                                bottom: 3,
                                right: 57,
                                child: Text(
                                  points.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 132, 168, 116),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                            Positioned(
                                bottom: 3,
                                right: 20,
                                child: Text(
                                  " / " + leveltotal.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 135, 135, 135),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ])))),
            ],
          ),
        ),
      ),
    );
  }

  Future getNewsList() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _newsList = List.from(data.docs.map((doc) => Article.fromSnapshot(doc)));
    });
  }
}
