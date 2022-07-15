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
      description: json['question'],
      levelID: json['answers'],
      lvlpoints: json['points'],
    );
  }
}
