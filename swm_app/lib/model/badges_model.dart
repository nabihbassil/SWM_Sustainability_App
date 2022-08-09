class Badges {
/* 

The Badges data model is used to display badges on the screens/badges.dart insde
the profile screen and the screens/success_module.dart after finishing a module.

*/

  String? module; //Badge name
  String? icon; //Path to icon
  bool? earned; //Is this badge earned by the user
  int? relateModID; //To which challenge module is this badge related

  Badges({this.module, this.icon, this.earned, this.relateModID});

//This function retrieves data from the Firebase database.
  factory Badges.fromJson(Map<String, dynamic> json) {
    return Badges(
        module: json['module'],
        icon: json['icon'],
        earned: json['earned'],
        relateModID: json['relateModID']);
  }
}
