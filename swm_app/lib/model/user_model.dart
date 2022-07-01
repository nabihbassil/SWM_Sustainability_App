import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  int? points;
  String? imgURL;
  List? actionsDone;
  List? ModulesDone;
  List? ModulesInProgress;
  List? BadgesDone;
  List? QuizDone;

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
      'actionsDone': FieldValue.arrayUnion([]),
      'ModulesDone': FieldValue.arrayUnion([]),
      'BadgesDone': FieldValue.arrayUnion([]),
      'ModulesInProgress': FieldValue.arrayUnion([]),
      'QuizDone': FieldValue.arrayUnion([]),
    };
  }
}
