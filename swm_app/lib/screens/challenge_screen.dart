import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/screens/challenge_main.dart';
import 'package:swm_app/services/user_service.dart';

/* 
  This screen is the main modules page where users can see all challenges split
  into modules done, in progress and new.
  Users see the title of the module, category (which are of sustainability) and
  a picture detailing the type of module this is
*/

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({Key? key}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  List LProgress = ['0']; // List of module IDs that are in progress by the user
  List LDone = ['0']; // List of module IDs that are done by the user
  List LNew = ['0']; // List of module IDs that were not started yet by the user

/* 
  This method retrieves all modules done IDs for the logged in user

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * data is added to the List of done module IDs and added to the state
  
*/
  GetAllModulesDone() async {
    //data is retrieved from the user services page and set value in list
    await UserService().GetAllModulesDone().then((value) => LDone = value);
    if (mounted) {
      setState(() {
        LDone; //added to state
        /*List of new modules is a list of IDs of both done and in progress which
          in the query is all IDs NOT IN THIS LIST */
        LNew = LDone + LProgress;
      });
    }
  }

/* 
  This method retrieves all modules in progress IDs for the logged in user

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * data is added to the List of in progress module IDs and added to the state
  
*/
  GetAllModulesInProgress() async {
    //data is retrieved from the user services page and set value in list
    await UserService()
        .GetAllModulesInProgress()
        .then((value) => LProgress = value);
    if (mounted) {
      setState(() {
        LProgress; //added to state
        /*List of new modules is a list of IDs of both done and in progress which
          in the query is all IDs NOT IN THIS LIST */
        LNew = LDone + LProgress;
      });
    }
  }

/* 
On init load all module IDs that are done and in progress and through them
we infer which modules have not been started yet by the user
*/
  @override
  void initState() {
    super.initState();
    GetAllModulesInProgress(); //function for in progress module IDs
    GetAllModulesDone(); //function for done module IDs
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(20),
          child: Align(
              alignment: Alignment.center,
              child: Container(
                child: const Text(
                  "Challenges Overview",
                  style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 99, 99, 99),
                      fontWeight: FontWeight.bold),
                ),
              )),
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 252, 248, 239),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ExpansionTile(
                  title: const Text('In Progress',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.bold)),
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 210,
                        child: FutureBuilder(
                            /* Get module data that user have in the in progress
                            IDs array in user collection and then display it */
                            future: FirebaseFirestore.instance
                                .collection('modules')
                                .where("modID", whereIn: LProgress)
                                .get(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: Text('Loading...'));
                              }
                              /*
                              to avoid 0 and null and errors 1 is the new
                               empty meaning when length == 1 then its empty
                               display nice message
                               */
                              if (LProgress.length == 1) {
                                return Expanded(
                                    child: Center(
                                        child: Column(children: const [
                                  SizedBox(height: 20),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
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
                                ])));
                              }

                              //else return filled data
                              return Expanded(
                                  child: ListView(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                children: snapshot.data!.docs.map((item) {
                                  return Center(
                                    child: Row(children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 155,
                                            child: Text(
                                              item['modName'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 131, 131, 131),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          GestureDetector(
                                            //navigates you to the start of the challenge
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChallengeMain(
                                                            id: item['modID'],
                                                            name:
                                                                item['modName'],
                                                          )));
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              height: 150,
                                              width: 200,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      item['modIMG'],
                                                      fit: BoxFit.fitWidth,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                    ),
                                                    Container(height: 10),
                                                    Positioned(
                                                      top: 10,
                                                      left: 10,
                                                      child: Text(
                                                        item['category']
                                                            .replaceAll(
                                                                "\\n", "\n"),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                                  );
                                }).toList(),
                              ));
                            })),
                  ],
                  initiallyExpanded: true,
                ))),
        Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 238, 247, 249),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ExpansionTile(
                  title: const Text('Discover New',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 80, 80, 80),
                          fontWeight: FontWeight.bold)),
                  children: [
                    // I'll name the data fr
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 210,
                        child: FutureBuilder(
                            /* 
                            Get module data from list containing done and
                            in progress modules and look in firebase for ID's
                            NOT ON THAT LIST
                             */
                            future: FirebaseFirestore.instance
                                .collection('modules')
                                .where("modID", whereNotIn: LNew)
                                .get(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return const Center(child: Text('Loading...'));
                              }
                              /*
                              to avoid 0 and null and errors 1 is the new
                               empty meaning when length == 1 then its empty
                               display nice message
                               */
                              if (LNew.length == 1) {
                                return Expanded(
                                    child: Center(
                                        child: Column(children: const [
                                  SizedBox(height: 20),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 25, right: 25),
                                    child: Text(
                                      'Nothing more to see here.\n\nNew challenges will be added soon!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Color.fromARGB(
                                              255, 142, 142, 142),
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ])));
                              }

                              //else fill interface with module data
                              return Expanded(
                                  child: ListView(
                                shrinkWrap: false,
                                scrollDirection: Axis.horizontal,
                                children: snapshot.data!.docs.map((item) {
                                  return Center(
                                    child: Row(children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 155,
                                            child: Text(
                                              item['modName'],
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 131, 131, 131),
                                                  fontWeight: FontWeight.bold),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChallengeMain(
                                                            id: item['modID'],
                                                            name:
                                                                item['modName'],
                                                          )));
                                            }, //navigate user to challenge
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              height: 150,
                                              width: 200,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      item['modIMG'],
                                                      fit: BoxFit.fitWidth,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                    ),
                                                    Positioned(
                                                      top: 10,
                                                      left: 10,
                                                      child: Text(
                                                        item['category']
                                                            .replaceAll(
                                                                "\\n", "\n"),
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            color: Color
                                                                .fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontStyle: FontStyle
                                                                .italic),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      )
                                    ]),
                                  );
                                }).toList(),
                              ));
                            })),
                  ],
                ))),
        Container(
            width: MediaQuery.of(context).size.width,
            color: const Color.fromARGB(255, 245, 255, 243),
            child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: ExpansionTile(
                    title: const Text('Completed',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 80, 80, 80),
                            fontWeight: FontWeight.bold)),
                    children: [
                      // I'll name the data fr
                      SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 210,
                          child: FutureBuilder(
                              /* Get module data that user have in the ID in done
                            array in user collection and then display it */
                              future: FirebaseFirestore.instance
                                  .collection('modules')
                                  .where("modID", whereIn: LDone)
                                  .get(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return const Center(
                                      child: Text('Loading...'));
                                }
                                /*
                              to avoid 0 and null and errors 1 is the new
                               empty meaning when length == 1 then its empty
                               display nice message
                               */
                                if (LDone.length == 1) {
                                  return Expanded(
                                      child: Center(
                                          child: Column(children: const [
                                    SizedBox(height: 20),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 25, right: 25),
                                      child: Text(
                                        'Such empty :o\n\nYour completed challenges will show up here.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Color.fromARGB(
                                                255, 142, 142, 142),
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ])));
                                }

                                //else fill interface with data
                                return Expanded(
                                    child: ListView(
                                  shrinkWrap: false,
                                  scrollDirection: Axis.horizontal,
                                  children: snapshot.data!.docs.map((item) {
                                    return Center(
                                      child: Row(children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              width: 155,
                                              child: Text(
                                                item['modName'],
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Color.fromARGB(
                                                        255, 131, 131, 131),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChallengeMain(
                                                              id: item['modID'],
                                                              name: item[
                                                                  'modName'],
                                                            )));
                                              }, //navigate user to challenge
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20),
                                                height: 150,
                                                width: 200,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                        item['modIMG'],
                                                        fit: BoxFit.fitWidth,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                      ),
                                                      Positioned(
                                                        top: 10,
                                                        left: 10,
                                                        child: Text(
                                                          item['category']
                                                              .replaceAll(
                                                                  "\\n", "\n"),
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ]),
                                    );
                                  }).toList(),
                                ));
                              })),
                    ]))),
      ],
    );
  }
}
