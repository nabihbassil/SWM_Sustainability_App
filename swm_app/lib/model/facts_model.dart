class Facts {
/* 

The Facts data model is used to display a fact instance on the 
screens/facts_screen.dart throught the facts services.

*/

  String? awatitle; //Fact title
  String? awaimg; //Path to image in each fact
  String? awatext; // Fact content
  String? parentmoduleid; // To which challenge module is the fact related

  Facts({this.awatitle, this.awaimg, this.awatext, this.parentmoduleid});

//This function retrieves data from the Firebase database.
  factory Facts.fromJson(Map<String, dynamic> json) {
    return Facts(
        awatitle: json['awatitle'],
        awatext: json['awatext'],
        awaimg: json['awaimg'],
        parentmoduleid: json['parentmoduleid']);
  }
}
