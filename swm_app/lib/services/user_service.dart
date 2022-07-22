// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swm_app/model/badges_model.dart';
import 'package:swm_app/model/user_model.dart';

class UserService {
  final User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  Future getUserData() async {
    await FirebaseFirestore.instance
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
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "actionsDone": FieldValue.arrayUnion([ID])
    });
  }

  void UpdateQuizDone(ID) async {
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "QuizDone": FieldValue.arrayUnion([ID])
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

  Future GetAllActionDone() async {
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

  Future GetAllModulesDone() async {
    List<String>? _list;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.ModulesDone!.toList(growable: true);
  }

  Future GetAllModulesInProgress() async {
    List<String>? _list;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.ModulesInProgress!.toList(growable: true);
  }

  Future<bool> GetIfQuizDone(modID) async {
    List<String>? _list;
    List? LQuizzes = ['0'];
    String quizID = '';
    List lst = [''];
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });

    LQuizzes = loggedInUser.QuizDone;

    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('quiz')
        .where("parentmoduleid", isEqualTo: modID)
        .get();

    print(qShot.docs.length);

    lst = qShot.docs.map((doc) => quizID = doc.id).toList();
    quizID = lst[0];

    print(LQuizzes);
    print(quizID);

    bool isQuizDone = LQuizzes!.contains(quizID);
    return isQuizDone;
  }

  Future<int> GetSizeofToDoTasks(modID, LTasks) async {
    int notDoneTasksLength = -1;
    print("modID $modID");
    await FirebaseFirestore.instance
        .collection('takeactions')
        .where("parentmoduleid", isEqualTo: modID)
        .where(FieldPath.documentId, whereNotIn: LTasks)
        .get()
        .then((value) => notDoneTasksLength = value.size);

    print("notDoneTasksLength $notDoneTasksLength");

    return notDoneTasksLength;
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

  Future<String> GetRelatedBadges(ID) async {
    String docID = "";
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('badges')
        .where("relateModID", isEqualTo: ID)
        .get();

    List<String> allData1 = qShot.docs.map((doc) => docID = doc.id).toList();

    return docID;
  }

  void CompleteModuleBadges(ID) async {
    String badgeID = await GetRelatedBadges(ID);
    print("warum $badgeID");
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "BadgesDone": FieldValue.arrayUnion([badgeID])
    });
  }

  Future<bool> updateModuleLogic(ID, isQuizDone, notDoneTasksLength) async {
    print("notDoneTasksLength $notDoneTasksLength");
    print("boolquiz $isQuizDone");

    if (isQuizDone && notDoneTasksLength == 0) {
      setModuleDone(ID);
      CompleteModuleBadges(ID);

      return true;
    } else {
      setModuleInProgress(ID);
      return false;
    }
  }

  Future<bool> IsQuizAlreadyDone(String quizRefID) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.QuizDone!.contains(quizRefID);
  }
}
