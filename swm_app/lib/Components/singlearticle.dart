import 'package:flutter/material.dart';
import 'package:swm_app/model/news_model.dart';
import 'package:intl/intl.dart';
import 'package:swm_app/screens/single_news.dart';

class ArticleCard extends StatelessWidget {
  final Article _article;
  const ArticleCard(this._article);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 200,
        child: Card(
          child: Column(
            children: [
              Row(children: [
                Expanded(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 15, right: 15, bottom: 8),
                        child: Expanded(
                            child: Text(
                          "${_article.title}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 39, 39, 39)),
                        )))),
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                        DateFormat('dd/MM/yy')
                            .format(_article.date!)
                            .toString(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 124, 124, 124))))
              ]),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(
                              left: 15, right: 15, bottom: 10),
                          child: Expanded(child: Text("${_article.summary}"))))
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
                    // Foreground color
                    onPrimary: Colors.lightGreen,
                    // Background color
                    primary: const Color.fromARGB(255, 215, 240, 206)),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SingleNewsScreen(title: _article.title ?? "")));
                },
                child: const Text(
                  'Learn More',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 85, 148, 75),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
