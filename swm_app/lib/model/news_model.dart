class Article {
  String? title;
  String? summary;
  String? bodytext;
  DateTime? date;
  String? link;

  Article();
  Article.fromSnapshot(snapshot)
      : title = snapshot.data()['title'],
        summary = snapshot.data()['summary'],
        bodytext = snapshot.data()['bodytext'],
        date = snapshot.data()['date'].toDate(),
        link = snapshot.data()['link'];
}
