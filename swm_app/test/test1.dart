import 'package:cloud_firestore/cloud_firestore.dart';

class FactService {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('awafacts');

  Future getFactsList() async {
    List itemsList = [];
    var data;
    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print("data is   ${element.data()}");
          itemsList.add(element.data);
        });
      });
    } catch (e) {
      print("${e.toString()}");
      return null;
    }
    return data;
  }
}
    


/*
  Future getFactsList() async {
    List itemsList = [];

    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          print("data is   ${element.data()}");
          itemsList.add(element.data);
        });
      });
    } catch (e) {
      print("errrrrrrrorrrrrrrrrrr  ${e.toString()}");
      return null;
    }
  }*/