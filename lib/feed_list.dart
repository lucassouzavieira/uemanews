import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';

class FeedList extends StatefulWidget {
  @override
  createState() => FeedListState();
}

class FeedListState extends State<FeedList> {
  final _news = <RssItem>[];
  final _smallFont = const TextStyle(fontSize: 11.0);
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildNews() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        return _buildRow(_news[i]);
      },
      itemCount: _news.length,
    );
  }

  List<RssItem> _getFeedItens() async {
    var client = new http.Client();

    final feed = await client.get("http://www.uema.br/feed/").then((response) {
      return response.body;
    }).then((bodyString) {
      return RssFeed.parse(bodyString);
    });

    return feed.items;
  }

  Widget _buildRow(RssItem item) {
    return new ListTile(
      title: Text(
        item.title,
        style: _biggerFont,
      ),
      subtitle: Text(
        item.description,
        style: _smallFont,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _news.addAll(_getFeedItens());

    return new Scaffold(
      appBar: AppBar(
        title: Text("Uema News"),
      ),
      body: _buildNews(),
    );
  }
}
