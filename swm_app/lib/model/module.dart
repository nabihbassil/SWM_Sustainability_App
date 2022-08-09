class ModuleModel {
/* 
**NOT USED.**
The ModuleModel data model is used to display info about each module.
We ended up not using this as we altered the logic of modules.
The logic can be found on screens/challenge_screen.dart
*/
  String? category; // Module category (consumption, energy)
  String? modID; // Module ID
  String? modIMG; // Path to module image
  String? modName; // Module title

  ModuleModel({this.category, this.modID, this.modIMG, this.modName});

//This function retrieves data from the Firebase database.
  factory ModuleModel.fromMap(map) {
    return ModuleModel(
        category: map['category'],
        modID: map['modID'],
        modIMG: map['modIMG'],
        modName: map['modName']);
  }
}
