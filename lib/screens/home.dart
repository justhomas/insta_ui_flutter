import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insta_flutter/providers/Posts.dart';
import 'package:insta_flutter/widgets/postWidget.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    await Provider.of<Posts>(context).fetchPosts();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.camera), onPressed: () {}),
          leadingWidth: 25,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                color: Colors.white,
              ),
            )
          ],
          title: Text(widget.title),
        ),
        body: Consumer<Posts>(
          builder: (context, posts, _) => Container(
              child: loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : posts.postsList.length == 0
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
                          itemCount: posts.postsList.length,
                          itemBuilder: (context, item) {
                            return PostWidget(
                              title: "",
                            );
                          })),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
