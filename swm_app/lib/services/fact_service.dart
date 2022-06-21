import 'package:cloud_firestore/cloud_firestore.dart';

class FactService {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('awafacts');

  int counter = 0;

  Future getFactsList() async {
    List itemsList = [];
    try {
      await profileList.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data);
        });
      });
      return itemsList;
    } catch (e) {
      print("error ${e.toString()}");
      return null;
    }
  }
}
