import 'package:flutter/material.dart';
import 'package:swm_app/model/news_model.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

/* 
  This component is used in screens/home_screen.dart and screens/news_screen.dart.
  This Class displays a news instance displayed in the UI.

  Inputs:
  * Article data model containing data such as title, article link, description.

  Outputs:
  * Card shape containg Article model data designed nicely.
  
*/

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
                            top: 10, left: 15, right: 15, bottom: 7),
                        child: Expanded(
                            child: Text(
                          "${_article.title}",
                          style: const TextStyle(
                              fontSize: 15,
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
                              left: 15, right: 15, bottom: 5),
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
                onPressed: () async {
                  final Uri url = Uri.parse(_article.link.toString());

                  await canLaunchUrl(url)
                      ? await launchUrl(url, mode: LaunchMode.inAppWebView)
                      : throw 'Could not lunch $url';
                },
                child: const Text(
                  'Learn More',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 85, 148, 75),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
