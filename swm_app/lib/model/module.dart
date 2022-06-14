class ModuleModel {
  String? category;
  String? modID;
  String? modIMG;
  String? modName;

  ModuleModel({this.category, this.modID, this.modIMG, this.modName});

  // receiving data from server
  factory ModuleModel.fromMap(map) {
    return ModuleModel(
        category: map['category'],
        modID: map['modID'],
        modIMG: map['modIMG'],
        modName: map['modName']);
  }
}
