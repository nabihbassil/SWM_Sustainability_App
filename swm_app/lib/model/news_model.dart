class Article {
/* 
The Article data model is used to display info about each article.
this data model is used in screens/home_screen.dart (home screen) and
screens/news_screen.dart (articles section).
*/
  String? title; // Article title
  String? summary; // Short description of the article
  DateTime? date; // Date the article was added to app
  String? link; // link to the actual article to open in the browser

  Article();

  //This function retrieves data from the Firebase database.
  Article.fromSnapshot(snapshot)
      : title = snapshot.data()['title'],
        summary = snapshot.data()['summary'],
        date = snapshot.data()['date'].toDate(),
        link = snapshot.data()['link'];
}
