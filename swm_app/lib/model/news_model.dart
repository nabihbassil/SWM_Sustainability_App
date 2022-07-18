class Article {
  String? title;
  String? summary;
  DateTime? date;
  String? link;

  Article();
  Article.fromSnapshot(snapshot)
      : title = snapshot.data()['title'],
        summary = snapshot.data()['summary'],
        date = snapshot.data()['date'].toDate(),
        link = snapshot.data()['link'];
}
