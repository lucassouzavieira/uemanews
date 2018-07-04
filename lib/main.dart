import 'package:flutter/material.dart';
import 'feed_list.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Uema News',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: FeedList()
    );
  }
}
