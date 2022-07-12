
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:swm_app/Components/singlearticle.dart';
import 'package:swm_app/model/news_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Articles",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: 400,
                  height: 500,
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

  Future getNewsList() async {
    var data = await FirebaseFirestore.instance
        .collection('news')
        .orderBy('date', descending: true)
        .get();

    setState(() {
      _newsList = List.from(data.docs.map((doc) => Article.fromSnapshot(doc)));
    });
  }
}
