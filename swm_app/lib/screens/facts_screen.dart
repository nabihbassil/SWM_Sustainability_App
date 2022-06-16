import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/model/facts_model.dart';

class FactsScreen extends StatelessWidget {
  Future<List<Facts>> fetchData() async {
    List<Facts> result = [];
    FirebaseFirestore.instance
        .collection("awafacts")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print(doc.data());
        Facts cat = Facts.fromJson(doc.data());
        result.add(cat);
      });
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    fetchData();
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
    ));
  }
}
