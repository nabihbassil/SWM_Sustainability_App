import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swm_app/model/facts_model.dart';

class FactService {
  final CollectionReference profileList =
      FirebaseFirestore.instance.collection('awafacts');

  int counter = 0;

  Future getFactsList(id) async {
    List itemsList = [];
    try {
      await profileList.get().then((querySnapshot) {
        for (var element in querySnapshot.docs) {
          itemsList.add(element.data);
        }
      });
      return itemsList;
    } catch (e) {
      print("error ${e.toString()}");
      return null;
    }
  }

  Future<List<Facts>> getUserTaskList(id) async {
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('awafacts')
        .where("parentmoduleid", isEqualTo: id)
        .get();

    print("qshot is ${qShot.docs.length}  id is $id");

    return qShot.docs
        .map((doc) => Facts(
            awatext: doc.get("awatext"),
            awatitle: doc.get("awatitle"),
            awaimg: doc.get("awaimg")))
        .toList();
  }
}
