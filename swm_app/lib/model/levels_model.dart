class Level {
  String? description;
  int? levelID;
  int? lvlpoints;

  Level({
    this.description,
    this.levelID,
    this.lvlpoints,
  });

  Level.fromSnapshot(snapshot)
      : description = snapshot.data()['description'],
        levelID = snapshot.data()['levelID'],
        lvlpoints = snapshot.data()['lvlpoints'];
}
