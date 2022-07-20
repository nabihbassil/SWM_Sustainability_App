import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/model/badges_model.dart';
import 'package:swm_app/page_holder.dart';

class Success extends StatefulWidget {
  int id;
  Success({Key? key, required this.id}) : super(key: key);

  @override
  State<Success> createState() => _SuccessState(id);
}

class _SuccessState extends State<Success> {
  int id;
  String modN = "";
  String badgeN = "";
  String badgeP = "1";
  List modName = [''];
  List badgeAttr = [''];
  _SuccessState(this.id);

  Future GetData() async {
    print("id $id");

    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('modules')
        .where("modID", isEqualTo: id)
        .get();
    modName = qShot.docs.map((doc) => modN = doc.get("modName")).toList();

    print("module ${modName[0]}");

    QuerySnapshot qShot1 = await FirebaseFirestore.instance
        .collection('badges')
        .where("relateModID", isEqualTo: id)
        .get();
    badgeAttr = qShot1.docs
        .map((doc) => Badges(module: doc.get("name"), icon: doc.get("icon")))
        .toList();

    modN = modName[0];
    badgeN = badgeAttr[0].module;
    badgeP = badgeAttr[0].icon;

    setState(() {
      modName;
      badgeAttr;
      modN;
      badgeN;
      badgeP;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    GetData();
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
                            text: "$modN.",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
                        const TextSpan(text: ' You win the badge '),
                        TextSpan(
                            text: "$badgeN.",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ),
                ),
                Image(
                  image: AssetImage("assets/badges/badge$badgeP.png"),
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
