class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? lastName;
  int? points;
  String? imgURL;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.lastName,
      this.points,
      this.imgURL});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      points: map['points'],
      imgURL: map['imgURL'],
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
    };
  }
}
