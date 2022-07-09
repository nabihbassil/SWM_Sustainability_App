class Article {
  String? title;
  String? summary;
  String? bodytext;
  DateTime? date;

  Article();
  Article.fromSnapshot(snapshot)
      : title = snapshot.data()['title'],
        summary = snapshot.data()['summary'],
        bodytext = snapshot.data()['bodytext'],
        date = snapshot.data()['date'].toDate();
}
