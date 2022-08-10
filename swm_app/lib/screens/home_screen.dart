import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/Components/singlearticle.dart';
import 'package:swm_app/model/levels_model.dart';
import 'package:swm_app/model/news_model.dart';
import 'package:swm_app/model/user_model.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/screens/levels.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:swm_app/services/user_service.dart';

/* 
  This screen is the Home page of the app where users see the most important info
  such as their current challenges, current level and newest articles posted
  
*/

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Object> _newsList = []; //List of newest articles
  List _levelsList = []; //List of levels and their description

  int points = 0; //user points
  int level = 0; //user current level
  int leveltotal = 10000; //total number of points of a certain level

  List currentModules = ['0']; //list of modules in progress IDs
  UserModel userData = UserModel(); //instance of user data model

/* 
  This method retrieves from user services data about the logged in user

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * data is added to the instance of user data model added to the state
  
*/
  fetchUserData() async {
    //call to retrieve data
    userData = await UserService().getUserData();

    setState(() {
      userData; //retrieved user data
      points = userData.points!; //current user points
    });
  }

/* 
  This method retrieves the levels and their corresponding info

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * Set the current level of the user and display it on the interface
  
*/
  Future getLevelList() async {
    //await fetchUserData();

    //database call
    var datas = await FirebaseFirestore.instance
        .collection('Levels')
        .orderBy('levelID', descending: false)
        .get();

    //filling results in list
    List _levelTempList = datas.docs
        .map((doc) => Level(
              description: doc.get("description"),
              levelID: doc.get("levelID"),
              lvlpoints: doc.get("lvlpoints"),
            ))
        .toList();

    //if user has more points than the level max points then he is next level
    int counter = 0;
    for (var i = 0; i < _levelTempList.length; i++) {
      if (points > _levelTempList[i].lvlpoints) {
        counter = counter + 1;
      } else {
        break;
      }
    }

    debugPrint(counter.toString());
    //set the total points of the current level
    int totalpts = _levelTempList[counter].lvlpoints!;

    setState(() {
      _levelsList = _levelTempList;
      level = counter + 1;
      leveltotal = totalpts;
    });
  }

/* 
  This method retrieves the modules that are in progress

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * Set the current modules list of the user in the state
  
*/
  GetAllModulesInProgress() async {
    //connect with the user service to retrieve data
    await UserService()
        .GetAllModulesInProgress()
        .then((value) => currentModules = value);

    if (mounted) {
      setState(() {
        currentModules;
      });
    }
  }

/* 
  This method retrieves the articles from the database

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * Set the news list in the state
  
*/
  Future getNewsList() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _newsList = List.from(data.docs.map((doc) => Article.fromSnapshot(doc)));
    });
  }

/*
On init all the different components are loaded like info about new articles,
current level, in progress modules and getting the user data to be able to perform
all previously mentioned tasks
 */
  @override
  void initState() {
    super.initState();
    fetchUserData(); //retrieve user data
    getNewsList(); //retrieve recent articles
    GetAllModulesInProgress(); //retrieve in progress modules IDs
    getLevelList(); //retrieve current level and info
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
                      //load module data based of IDs of modules in progress from the user
                      future: FirebaseFirestore.instance
                          .collection('modules')
                          .where("modID", whereIn: currentModules)
                          .get(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: Text('Loading...'));
                        }
                        /*
                              to avoid 0 and null and errors 1 is the new
                               empty meaning when length == 1 then its empty
                               display nice message
                               */
                        if (currentModules.length == 1) {
                          return Expanded(
                              child: Container(
                                  height: 100,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 227, 227, 227),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  child: Center(
                                      child: Column(children: const [
                                    SizedBox(height: 10),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 35, right: 35),
                                      child: Text(
                                        'You have no challenges in progress.\n\nDiscover some new challenges and learn about how you can be more sustainable in your daily life!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 142, 142, 142),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ]))));
                        } else {
                          //else populate modules with the interface
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
                                        width:
                                            MediaQuery.of(context).size.width -
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Stack(
                                            children: [
                                              Image.asset(
                                                item['modIMG'],
                                                fit: BoxFit.fitWidth,
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
                                                      fontWeight:
                                                          FontWeight.w500,
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
                        }
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
                    //display new articles
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
              //display current level and on click take you to the levels page
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Levels()));
                  },
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
                              right: 20,
                              child: Row(children: [
                                Text(
                                  points.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 132, 168, 116),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  " / " + leveltotal.toString(),
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 135, 135, 135),
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                            )
                          ])))),
            ],
          ),
        ),
      ),
    );
  }
}
