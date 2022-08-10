import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/model/badges_model.dart';

/*
In this page, users are congratulated for finishing a module and see their new badge
for the first time
 */
class Success extends StatefulWidget {
  int id; //module ID
  Success({Key? key, required this.id}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState(id);
}

class _SuccessState extends State<Success> {
  int id; //module ID
  String modNane = ""; //module name
  String badgeName = ""; //badge title
  String badgeID = "1"; //badge ID
  List modNameList = ['']; //List of module names
  List badgeAttr = ['']; //List of badge category
  _SuccessState(this.id);

/* 
  This method retrieves info about the new badge won

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * data about badge is added to the state
  
*/
  Future GetSuccessData() async {
    //get name of finished module
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('modules')
        .where("modID", isEqualTo: id)
        .get();
    modNameList =
        qShot.docs.map((doc) => modNane = doc.get("modNameList")).toList();

    //get badge name and badge icon
    QuerySnapshot qShot1 = await FirebaseFirestore.instance
        .collection('badges')
        .where("relateModID", isEqualTo: id)
        .get();
    badgeAttr = qShot1.docs
        .map((doc) => Badges(module: doc.get("name"), icon: doc.get("icon")))
        .toList();

    modNane = modNameList[0]; //set value of module name
    badgeName = badgeAttr[0].module; //set value of badge name
    badgeID = badgeAttr[0].icon; //set value of module name

    setState(() {
      modNameList;
      badgeAttr;
      modNane;
      badgeName;
      badgeID;
    });
  }

// on init, load the data related to the badge won
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    GetSuccessData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: const AssetImage("assets/success.gif"),
                  height: 100,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        const TextSpan(
                            text: 'You have successfully finished the module '),
                        TextSpan(
                            text: "$modNane.",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: ' You win the badge '),
                        TextSpan(
                            text: "$badgeName.",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
                Image(
                  image: AssetImage("assets/badges/badge$badgeID.png"),
                  height: 70,
                  width: 70,
                ),
                const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 24, vertical: 16)),
              ],
            ),
          ),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(30),
            color: Colors.green,
            child: MaterialButton(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                minWidth: 200,
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Ok",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ],
      ),
    );
  }
}
