import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swm_app/model/user_model.dart';

class UserService {
  final User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future getUserData() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser;
  }

  void UpdatePoints(points) async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      loggedInUser.points = (loggedInUser.points! + points) as int?;

      FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .set(loggedInUser.toMap(), SetOptions(merge: true));
    });
  }

  void UpdateActionDone(ID) async {
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "actionsDone": FieldValue.arrayUnion([ID])
    });
  }

  Future CheckActionDone(ID) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      print("test1");
      print("${loggedInUser.actionsDone!.contains(ID)}");
      print("id is $ID");
    });
    return true;
  }

  Future GetAllActionDone(modID) async {
    List<String>? _list;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.actionsDone!.toList(growable: true);
  }
}
