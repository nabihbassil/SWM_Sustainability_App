// ignore_for_file: non_constant_identifier_names

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
    });
    return loggedInUser.actionsDone!.contains(ID);
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

  Future GetAllQuizzesDone(modID) async {
    List<String>? _list;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.QuizDone!.toList(growable: true);
  }

  void setModuleInProgress(ID) async {
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "ModulesInProgress": FieldValue.arrayUnion([ID])
    });
  }

  void setModuleDone(ID) async {
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "ModulesDone": FieldValue.arrayUnion([ID])
    });

    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "ModulesInProgress": FieldValue.arrayRemove([ID])
    });
  }

  void updateModuleLogic(ID) async {
    List LTasks = ['0'];
    List LQuizzes = ['0'];
    String quizID = "";
    //int ListLength = 0;

    print("in func $ID");

    await GetAllActionDone(ID).then((value) => LTasks = value);
    // ListLength = LTasks.length;
    print("L1 $LTasks");

    /*var DoneTasksLength = await FirebaseFirestore.instance
        .collection('takeactions')
        .where("parentmoduleid", isEqualTo: ID)
        .where(FieldPath.documentId, whereIn: LTasks)
        .snapshots()
        .length;

    print("DOOOOOOOOONNNEEEEEE $DoneTasksLength");*/

    var notDoneTasksLength = await FirebaseFirestore.instance
        .collection('takeactions')
        .where("parentmoduleid", isEqualTo: ID)
        .where(FieldPath.documentId, whereNotIn: LTasks)
        .snapshots()
        .length;

    print("NOOOOTTT $notDoneTasksLength");

    await GetAllQuizzesDone(ID).then((value) => LQuizzes = value);

    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('quiz')
        .where("parentmoduleid", isEqualTo: ID)
        .get();

    qShot.docs.map((doc) async => {quizID = doc.id});

    bool isQuizDone = LQuizzes.contains(quizID);

    if (isQuizDone && notDoneTasksLength == 0) {
      setModuleDone(ID);
    } else {
      setModuleInProgress(ID);
    }
  }
}
