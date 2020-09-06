import 'package:flutter/material.dart';

class TextView extends StatelessWidget {

  Map<String, dynamic> data;

  TextView(this.data);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        data['text'] ?? 'Add the text property to display text here',
        style: Theme.of(context).textTheme.headline4,
      ),
    );
  }
}
