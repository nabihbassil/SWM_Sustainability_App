// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:swm_app/page_holder.dart';
import 'package:swm_app/screens/success_module.dart';
import 'package:swm_app/services/user_service.dart';
import "package:url_launcher/url_launcher.dart";
import 'package:url_launcher/url_launcher_string.dart';

/* 
On this screen, users can see how to complete the action and complete it
*/
class SingleActionScreen extends StatefulWidget {
  String id; //reference ID of the actino
  int modID; //module ID
  SingleActionScreen({Key? key, required this.id, required this.modID})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  _SingleActionScreenState createState() => _SingleActionScreenState(id, modID);
}

class _SingleActionScreenState extends State<SingleActionScreen> {
  String id; //reference ID of the actino
  int modID; //module ID
  _SingleActionScreenState(this.id, this.modID);
  late bool _isButtonDisabled; //disable complete button if already completed
  var _isActionDone = false; //check if action was already done before

/* 
  This method disables the complete button

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * boolean to disable button is saved in the state
  
*/
  void _DisableButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

/* 
  This method updates user point after completing action

  Inputs:
  * points: amount of points won

  Outputs:
  * NO RETURN OUTPUT
  * user point tally is updated
  
*/
  UpdateUserPoints(points) {
    //call user services to update database
    UserService().UpdatePoints(points);
  }

/* 
  This method add the action ID to the user's actions done list

  Inputs:
  * ID: reference ID of the action
  * modID: module ID

  Outputs:
  * NO RETURN OUTPUT
  * action added is done list of user
  * check if whole module is done and award badge to user
  
*/
  UpdateActionDone(ID, modID) async {
    List DoneTasks = ['0']; //list of action IDs done by user
    bool isQuizDone = false; //is the module quiz done
    int notDoneLength = -1; //length of list of action IDs not done
    bool finished = false; //is module done

    UserService().UpdateActionDone(ID); //update user list of action IDs done

    //gets the list of actions done to see if the whole module is done
    DoneTasks = await UserService()
        .GetAllActionDone()
        .then((value) => DoneTasks = value);
    //check if the module quiz is done
    isQuizDone = await UserService().GetIfQuizDone(modID);
    //gets number of actions not done. 0 = all actions have been done
    notDoneLength = await UserService().GetSizeofToDoTasks(modID, DoneTasks);
    //check if the whole module has been finished (complete quiz and all actions)
    finished =
        await UserService().updateModuleLogic(modID, isQuizDone, notDoneLength);

    if (finished == true) {
      //module is finished, wait one second and navigate to congrats page
      var future = new Future.delayed(
          const Duration(seconds: 1),
          (() => Navigator.push(context,
              MaterialPageRoute(builder: (context) => Success(id: modID)))));
    }
  }

/* 
  This method checks if action ID already exists for user then it has been done before

  Inputs:
  * ID: reference ID of the action

  Outputs:
  * NO RETURN OUTPUT
  * boolean if action was done before is saved in the state
  
*/
  CheckActionDone(ID) async {
    //call user services to retrieve data
    await UserService()
        .CheckActionDone(ID)
        .then((value) => _isActionDone = value);

    if (mounted) {
      setState(() {
        _isActionDone;
      });
    }
  }

/*on init we check if we should disable the button on page load so the user can't win
duplicate points anymore */
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    _isButtonDisabled = false;
    CheckActionDone(id);
  }

  @override
  Widget build(BuildContext context) {
    CheckActionDone(id); //not necessary anymore

    //get data about action
    final Query _collectionRef = FirebaseFirestore.instance
        .collection('takeactions')
        .where(FieldPath.documentId, isEqualTo: id);

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
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const PageHolder()));
            },
          )
        ],
      ),
      body: Center(
        child: StreamBuilder(
            stream: _collectionRef.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              //display action data
              return ListView(
                children: snapshot.data!.docs.map((item) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(35),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              width: double.infinity,
                              child: Text(
                                item['actiontitle'],
                                style: const TextStyle(
                                    fontSize: 24,
                                    color: Color.fromARGB(255, 70, 70, 70),
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.left,
                              )),
                          Container(height: 20),
                          ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                item['actionimg'],
                                width: double.infinity,
                              )),
                          Container(height: 20),
                          SizedBox(
                              width: double.infinity,
                              child: Html(
                                  //display HTML data to customize text (bold, links, etc...)
                                  data: item['actioncontent'],
                                  onLinkTap: (url, _, __, ___) async {
                                    //make links clickable and open browser
                                    if (await canLaunchUrlString(url!)) {
                                      await launchUrlString(url,
                                          mode: LaunchMode.inAppWebView);
                                    }
                                  },
                                  //CSS like styling for tags
                                  style: {
                                    "p": Style(
                                        color: Color.fromARGB(255, 48, 48, 48),
                                        fontSize: FontSize(16))
                                  })),
                          Container(height: 20),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                //should the button be disabled or not
                                !_isActionDone
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // Foreground color
                                          onPrimary: const Color.fromARGB(
                                              255, 228, 170, 18),
                                          // Background color
                                          primary: const Color.fromARGB(
                                              255, 255, 239, 199),
                                          minimumSize: const Size(200, 50),
                                        ),
                                        onPressed: () {
                                          if (_isButtonDisabled) {
                                            null;
                                          } else {
                                            UpdateActionDone(
                                                item.reference.id, modID);
                                            UpdateUserPoints(
                                                int.parse(item['actionpts']));
                                          }
                                        },
                                        child: Text(
                                          _isButtonDisabled
                                              ? "Good Job on Completing the Task"
                                              : "I Did This!",
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ))
                                    : ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // Foreground color
                                          onPrimary: const Color.fromARGB(
                                              255, 85, 148, 75),
                                          // Background color
                                          primary: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          minimumSize: const Size(200, 50),
                                        ),
                                        onPressed: null,
                                        child: const Text(
                                            'Good Job on Completing the Task!',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 85, 148, 75),
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.bold)),
                                      )
                              ]),
                          Container(height: 10),
                          Text(
                            item["actionpts"] + "pts",
                            style: const TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 228, 170, 18),
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
