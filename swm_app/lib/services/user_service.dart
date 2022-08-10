import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swm_app/model/user_model.dart';

class UserService {
  /* 

The User Service page contains functions that link all user related tasks to the 
Firebase database.

*/
  final User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

/* 
  This function returns data of logged in user. 

  Inputs:
  NO INPUTS

  Outputs:
  * User data model containing logged user data
  
*/
  Future getUserData() async {
    //Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser;
  }

/* 
  This function adds points to user's existing tally. 

  Inputs:
  *points: is the amount of points won from doing a certain action

  Outputs:
  * NO return OUTPUT
  * Database update of the user's points
  
*/
  void UpdatePoints(points) async {
    //Firebase call to retrieve user data
    FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());

      //new points added to existing points
      loggedInUser.points = (loggedInUser.points! + points) as int?;

      //update user data with new points tally
      FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .set(loggedInUser.toMap(), SetOptions(merge: true));
    });
  }

/* 
  This function adds the reference ID of a completed action to the user's
  array of done actions. 

  Inputs:
  *ID: Reference ID of the completed action

  Outputs:
  * NO return OUTPUT
  * Database update of the user's actions done array
  
*/
  void UpdateActionDone(ID) async {
    //Firebase call to retrieve user data then update the array with new ID
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "actionsDone": FieldValue.arrayUnion([ID])
    });
  }

/* 
  This function adds the reference ID of a completed quiz to the user's
  array of quizzes actions. 

  Inputs:
  *ID: Reference ID of the completed quiz

  Outputs:
  * NO return OUTPUT
  * Database update of the user's quizzes done array
  
*/
  void UpdateQuizDone(ID) async {
    //Firebase call to retrieve user data then update the array with new ID
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "QuizDone": FieldValue.arrayUnion([ID])
    });
  }

/* 
  This function adds the reference ID of a newly started module to the user's
  array of modules in progress. 

  Inputs:
  *ID: Reference ID of the started module

  Outputs:
  * NO return OUTPUT
  * Database update of the user's modules in progress array
  
*/
  void setModuleInProgress(ID) async {
    //Firebase call to retrieve user data then update the array with new ID
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "ModulesInProgress": FieldValue.arrayUnion([ID])
    });
  }

/* 
  This function adds the reference ID of a completed module to the user's
  array of modules done and removes it from the array of modules in progress. 

  Inputs:
  *ID: Reference ID of the completed module

  Outputs:
  * NO return OUTPUT
  * Database updates of the user's arrays of modules done and in progress
  
*/
  void setModuleDone(ID) async {
    //Firebase call to retrieve user data then update the array with new ID
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "ModulesDone": FieldValue.arrayUnion([ID])
    });

    //Firebase call to retrieve user data then update the array removing the ID
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "ModulesInProgress": FieldValue.arrayRemove([ID])
    });
  }

/* 
  This function adds the reference ID of a completed badge to the user's
  array of badges done.

  Inputs:
  *ID: ID of the completed module

  Outputs:
  * NO return OUTPUT
  * Database update of the user's arrays of badges done
  
*/
  void CompleteModuleBadges(ID) async {
    //function call to get ID of the badge related to a module
    String badgeID = await GetRelatedBadges(ID);

    //Firebase call to retrieve user data then update with new badge ID
    FirebaseFirestore.instance.collection("users").doc(user?.uid).update({
      "BadgesDone": FieldValue.arrayUnion([badgeID])
    });

    //workaround to show on the interface the badges won
    FirebaseFirestore.instance
        .collection("badges")
        .doc(badgeID)
        .update({"earned": true});
  }

/* 
  This function checks if an action has been done by searching in the user's
  array of actions done.

  Inputs:
  *ID: Reference ID of the action concerned

  Outputs:
  * Boolean value if the action is done or not
  
*/
  Future CheckActionDone(ID) async {
    //Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.actionsDone!.contains(ID);
  }

/* 
  This function checks if a quiz has been done by searching in the user's
  array of quizzes done.

  Inputs:
  *modID: ID of the module in use

  Outputs:
  * Boolean value if the quiz is done or not
  
*/
  Future<bool> GetIfQuizDone(modID) async {
    List? LQuizzes = ['0']; //List of quizzes
    String quizID = ''; // Reference ID of the quiz
    List lst = ['']; // Temporary List

    //Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });

    LQuizzes = loggedInUser.QuizDone;

    //Firebase call to retrieve quiz data of the related module
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('quiz')
        .where("parentmoduleid", isEqualTo: modID)
        .get();

    //get the quiz Reference ID used to check later if it exists in user array
    lst = qShot.docs.map((doc) => quizID = doc.id).toList();
    quizID = lst[0];

    bool isQuizDone = LQuizzes!.contains(quizID);
    return isQuizDone;
  }

  /* 
  This function determines after a task in a module has been done if the module
  is done of is it in progress.

  Inputs:
  * ID: ID of the module in use
  * isQuizDone: Boolean value if the module quiz is accomplished
  * notDoneTasksLength: Amount of tasks that have not been done yet

  Outputs:
  * Boolean value determining if a module is done or not
  
*/
  Future<bool> updateModuleLogic(ID, isQuizDone, notDoneTasksLength) async {
    // If quiz is done and there is 0 tasks to be done then module is completed
    if (isQuizDone && notDoneTasksLength == 0) {
      setModuleDone(ID); // Add the ID of the module to the user's done array
      CompleteModuleBadges(ID); // Add the new badge to the user's badge array
      return true;
    } else {
      setModuleInProgress(
          ID); // Add the ID of the module to the user's in progress array
      return false;
    }
  }

/* 
  This function determines if a quiz has been completed previously or not.

  Inputs:
  * quizRefID: ID of the quiz

  Outputs:
  * Boolean value determining if the quiz is done or not
  
*/
  Future<bool> IsQuizAlreadyDone(String quizRefID) async {
    // Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.QuizDone!.contains(quizRefID);
  }

/* 
  This function returns a List of all completed actions

  Inputs:
  NO INPUTS

  Outputs:
  * List of of actions completed
  
*/
  Future GetAllActionDone() async {
    //Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.actionsDone!.toList(growable: true);
  }

/* 
  This function returns a List of all completed modules

  Inputs:
  NO INPUTS

  Outputs:
  * List of of modules completed
  
*/
  Future GetAllModulesDone() async {
    //Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.ModulesDone!.toList(growable: true);
  }

/* 
  This function returns a List of all modules in progress

  Inputs:
  NO INPUTS

  Outputs:
  * List of of modules in progress
  
*/
  Future GetAllModulesInProgress() async {
    //Firebase call to retrieve user data
    await FirebaseFirestore.instance
        .collection("users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    });
    return loggedInUser.ModulesInProgress!.toList(growable: true);
  }

/* 
  This function returns a number of to do actions which is used to determine
  if all tasks have been done when determining if a module is completed

  Inputs:
  * modID: ID of the module in use
  * doneTasks: List of all actions already done

  Outputs:
  * Integer value of the number of actions left to do
  
*/
  Future<int> GetSizeofToDoTasks(modID, doneTasks) async {
    int notDoneTasksLength = -1;

    //Firebase call to retrieve actions data
    await FirebaseFirestore.instance
        .collection('takeactions')
        .where("parentmoduleid", isEqualTo: modID)
        .where(FieldPath.documentId, whereNotIn: doneTasks)
        .get()
        .then((value) => notDoneTasksLength = value.size);

    return notDoneTasksLength;
  }

/* 
  This function returns the reference ID of a badge related to a module. The
  reference ID is used to get added to the user's badges done

  Inputs:
  * ID: ID of the module in use

  Outputs:
  * Reference ID of the badge won 
  
*/

  Future<String> GetRelatedBadges(ID) async {
    String docID = "";

    // Firebase call to retrieve badges data
    QuerySnapshot qShot = await FirebaseFirestore.instance
        .collection('badges')
        .where("relateModID", isEqualTo: ID)
        .get();

    // Get reference ID off the retrieved data
    List<String> allData1 = qShot.docs.map((doc) => docID = doc.id).toList();

    return docID;
  }
}
