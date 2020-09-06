import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DefaultClock extends StatefulWidget {

  DefaultClock(dynamic info);

  @override
  _DefaultClockState createState() => _DefaultClockState();
}

class _DefaultClockState extends State<DefaultClock> {

  Timer t;
  final timeFormat = DateFormat('h:mm:ss a');
  final dateFormat = DateFormat('MMMM d, yyyy');

  @override
  void initState() {
    super.initState();
    t = Timer.periodic(Duration(seconds: 1), (_) => setState((){}));
  }

  @override
  void dispose() {
    t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateFormat.format(DateTime.now()),
            style: Theme.of(context).textTheme.headline4,
          ),
          Text(
            timeFormat.format(DateTime.now()),
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      )
    );
  }
}
