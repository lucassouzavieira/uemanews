import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class FeedList extends StatefulWidget {
  @override
  createState() => FeedListState();
}

class FeedListState extends State<FeedList> {
  RssFeed feed;
  final _smallFont = const TextStyle(fontSize: 11.0);
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  void initState() {
    super.initState();
    var client = new http.Client();

    client.get("http://www.uema.br/feed/").then((response) {
      return response.body;
    }).then((bodyString) {
      this.setState(() {
        feed = RssFeed.parse(bodyString);
      });
    });
  }

  Widget _buildNews() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        return _buildRow(feed.items[i]);
      },
      itemCount: feed.items.length,
    );
  }

  Widget _buildRow(RssItem item) {
    return new ListTile(
      title: Text(
        item.title,
        style: _biggerFont,
      ),
      subtitle: Text(
        item.pubDate,
        style: _smallFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Uema News"),
      ),
      body: _buildNews(),
    );
  }
}
