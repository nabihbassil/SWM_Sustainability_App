import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:swm_app/Components/singlearticle.dart';
import 'package:swm_app/model/news_model.dart';

/*
On this page, users see a list of all available articles to read. On click, the
user's browser is open where they can read the article from it's source.
*/
class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  List<Object> _newsList = [];
  final Query _news = FirebaseFirestore.instance.collection('news');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getNewsList();
  }

/* 
  This method retrieves the articles from the database

  Inputs:
  * NO INPUT

  Outputs:
  * NO RETURN OUTPUT
  * Set the news list in the state
  
*/
  Future getNewsList() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _newsList = List.from(data.docs.map((doc) => Article.fromSnapshot(doc)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Container(
                    child: Text(
                      "Articles",
                      style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 99, 99, 99),
                          fontWeight: FontWeight.bold),
                    ),
                  )),
              const SizedBox(height: 10),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.builder(
                    itemCount: _newsList.length,
                    itemBuilder: (context, index) {
                      return ArticleCard(_newsList[index] as Article);
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
