class Level {
/* 

The Level data model is used to display info about each level instance on the 
screens/home_screen.dart (home screen), screens/levels.dart (levels page), 
screens/profile_screen.dart (profile page).

*/
  String? description; //Info about what you win completing this level
  int? levelID; // ID of each level
  int? lvlpoints; //Points required to complete this level

  Level({
    this.description,
    this.levelID,
    this.lvlpoints,
  });

//This function retrieves data from the Firebase database.
  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      description: json['description'],
      levelID: json['levelID'],
      lvlpoints: json['lvlpoints'],
    );
  }
}
