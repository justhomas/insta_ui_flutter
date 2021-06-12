import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insta_flutter/providers/Posts.dart';
import 'package:insta_flutter/widgets/postWidget.dart';
import 'package:provider/provider.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  bool init = true;
  bool loading = false;
  @override
  void didChangeDependencies() {
    if (init) {
      fetch();
      setState(() {
        init = false;
      });
    }

    super.didChangeDependencies();
  }

  void fetch() async {
    setState(() {
      loading = true;
    });
    await Provider.of<Posts>(context).fetchBookmarkedPosts();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Posts>(
      builder: (context, posts, _) => Container(
          child: loading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : posts.bookMarkedPosts.length == 0
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                          child: Text(
                        'No items Added.',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      )),
                    )
                  : ListView.builder(
                      itemCount: min(30, posts.bookMarkedPosts.length),
                      itemBuilder: (context, item) {
                        return PostWidget(
                          title: posts.bookMarkedPosts[item]["title"],
                          thumbnail: posts.bookMarkedPosts[item]
                              ["high thumbnail"],
                          userName: posts.bookMarkedPosts[item]["channelname"],
                          id: posts.bookMarkedPosts[item]["id"],
                        );
                      })),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
