import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {

  bool isLoading = true;
  Dio dio = Dio(BaseOptions(followRedirects: true));
  List<Article> topHeadlines = List();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {

    Response res = await dio.get('https://gnews.io/api/v3/top-news?max=20&token=d63333b167ef9a9c9a12227f2f922a6f');

    for(int i = 0; i < res.data['articles'].length; i++) {
      topHeadlines.add(Article(
        res.data['articles'][i]['title'],
        res.data['articles'][i]['description'],
        res.data['articles'][i]['url'],
        res.data['articles'][i]['image'],
        res.data['articles'][i]['publishedAt'],
        res.data['articles'][i]['source']['name'],
      ));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (isLoading) return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          strokeWidth: 1.5,
          valueColor: AlwaysStoppedAnimation(Colors.white),
        ),
      ),
    );

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width / 2.2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: Text('News', style: Theme.of(context).textTheme.headline4, textAlign: TextAlign.left),
          ),
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 2,
            ),
            child: ListView(
              shrinkWrap: true,
              children: [
                for(Article article in topHeadlines)
                  Row(
                    children: [
                      Image.network(
                        // random news default thumbnail i found online
                        article.image ?? 'https://www.pshe-association.org.uk/sites/all/themes/PSHE/img/default-pshe-square.png',
                        height: 100,
                        width: 100,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2.2 - 116,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                article.title,
                                style: Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.w600),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                              ),
                              Text(
                                '${DateFormat('M/d h:mm a').format(DateFormat('yyyy-MM-dd hh:mm:ss').parse(article.publishedAt, true).toLocal())} | from ${article.sourceName}',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.left,
                                maxLines: 3,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Article {
  String title, description, url, image, publishedAt, sourceName;
  Article(this.title, this.description, this.url, this.image, this.publishedAt, this.sourceName);
}