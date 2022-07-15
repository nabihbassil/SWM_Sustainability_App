class Level {
  String? description;
  int? levelID;
  int? lvlpoints;

  Level({
    this.description,
    this.levelID,
    this.lvlpoints,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      description: json['description'],
      levelID: json['levelID'],
      lvlpoints: json['lvlpoints'],
    );
  }
}
