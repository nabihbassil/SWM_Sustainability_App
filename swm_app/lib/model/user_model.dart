import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
/* 

The UserModel data model is used to display retrieve user data. 
Other than the basic user data we also get the lists[actionsDone], [ModulesDone],
[ModulesInProgress], [BadgesDone], [QuizDone] used to track  user progress in
different parts.
screens/home_screen.dart (home screen), screens/levels.dart (levels page), 
screens/profile_screen.dart (profile page), screens/hamburger_menu.dart 
(burger menu component).
This model is also used in the user services.

*/
  String? uid; // User ID
  String? email; // User email
  String? firstName; // User first name
  String? lastName; // User last name
  int? points; // User points
  String? imgURL; // Path to user image in Firebase Firestorage
  List? actionsDone; // IDs of module actions done by user
  List? ModulesDone; // IDs of modules done by user
  List? ModulesInProgress; // IDs of modules in progress by user
  List? BadgesDone; // Badges won by user
  List? QuizDone; // IDs of Quizzes done by user

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.points,
      this.imgURL,
      this.actionsDone,
      this.ModulesDone,
      this.BadgesDone,
      this.ModulesInProgress,
      this.QuizDone});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      points: map['points'],
      imgURL: map['imgURL'],
      actionsDone: map['actionsDone'],
      ModulesDone: map['ModulesDone'],
      BadgesDone: map['BadgesDone'],
      ModulesInProgress: map['ModulesInProgress'],
      QuizDone: map['QuizDone'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'points': points,
      'imgURL': imgURL,
      'actionsDone': FieldValue.arrayUnion(['0']),
      'ModulesDone': FieldValue.arrayUnion(['0']),
      'BadgesDone': FieldValue.arrayUnion(['0']),
      'ModulesInProgress': FieldValue.arrayUnion(['0']),
      'QuizDone': FieldValue.arrayUnion(['0']),
    };
  }
}
