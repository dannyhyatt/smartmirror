import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smartmirror/generative_clock.dart';
import 'package:smartmirror/views/default_clock.dart';
import 'package:smartmirror/views/dots_clock_view.dart';
import 'package:smartmirror/views/news_view.dart';
import 'package:smartmirror/views/spotify_player.dart';
import 'package:smartmirror/views/stocks_view.dart';
import 'package:smartmirror/views/text_view.dart';
import 'package:smartmirror/views/weather_view.dart';

Map<String, dynamic> config = Map();

void main() {
  config = {
    "comment" : "look at https://github.com/dannyhyatt/smartmirror to see all widgets",
    "layout" : {
      "type" : "rows",
      "rows" : [
        [  // row 1
          {
//              "name" : "default_clock",
          }
        ]
      ]
    }
  };
  debugPrint('wtfff');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        textTheme: TextTheme(
            headline1: TextStyle(color: Colors.white, fontSize: 60),
            headline2: TextStyle(color: Colors.white, fontSize: 52, fontWeight: FontWeight.w200),
            headline4: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w200),
            headline5: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w200),
            headline6: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w200)
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class LoadingScreen extends StatelessWidget {

  void init(BuildContext ctx) async {
    debugPrint('oneee');
    Map<String, dynamic> defaultConfig = {
      "comment" : "look at https://github.com/dannyhyatt/smartmirror to see all widgets",
      "layout" : {
        "type" : "rows",
        "rows" : [
          [  // row 1
            {
//              "name" : "default_clock",
            }
          ]
        ]
      }
    };
    config = defaultConfig;
    Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (_) => MyHomePage(title: "Flutter Home Page")));
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          ),
        ),
        Text('Loading your config...', style: Theme.of(context).textTheme.headline4)
      ],
    );
  }

}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    config = {
      "comment" : "look at https://github.com/dannyhyatt/smartmirror to see all widgets",
      "layout" : {
        "type" : "rows",
        "rows" : [
          [  // row 1
            {
              "name" : "spacer",
            },
            {
              "name" : "spacer",
            }
          ],

          [  // row 2
            {
              "name" : "spacer",
            },
            {
              "name" : "generative_clock",
            },
            {
              "name" : "spacer",
            }
          ],

          [
            {
              "name" : "spacer",
            },
            {
              "name" : "spacer"
            }
          ]
        ]
      }
    };

    // rows will be the default layout type
    if(config['layout']['type'] == null || config['layout']['type'] == 'rows') {

      List<Row> rows = List();
      for(int i = 0; i < config['layout']['rows'].length; i++) {
        List<Widget> children = List();
        for(int j = 0; j < config['layout']['rows'][i].length; j++) {
          children.add(_getWidgetFromInfo(config['layout']['rows'][i][j]));
        }
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ));
      }

      return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: rows,
          ),
        ),
      );
    }
  }

  Widget _getWidgetFromInfo(dynamic info) {
    // there has to be a better way to do this
    switch(info['name']) {
      case 'default_clock' : return DefaultClock(info);
      case 'dots_clock' : return Container(
          constraints: BoxConstraints(
            maxHeight: 250,
            maxWidth: 350
          ),
          child: DotsClockView()
      );
      case 'generative_clock' : return SafeArea(
        child: Container(
            constraints: BoxConstraints(
                maxHeight: 250,
                maxWidth: 350,
              minHeight: 250,
              minWidth: 350,
            ),
            color: Colors.red,
            child: GenerativeClockView()
        ),
      );
      case 'news_view' : return NewsView();
      case 'stocks_view' : return StocksView();
      case 'text_view' : return TextView(info);
      case 'weather_view' : return WeatherView();
      case 'spacer' : return Container();
      default: return DefaultClock(info);
    }
  }

  _addSize(dynamic info) {
    info['height'] = 250.0;
    info['width']  = 350.0;
    return info;
  }

}
