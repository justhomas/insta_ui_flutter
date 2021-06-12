import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insta_flutter/providers/Posts.dart';
import 'package:insta_flutter/widgets/commentWidget.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late bool init, loading;

  @override
  void initState() {
    super.initState();
    setState(() {
      init = true;
      loading = true;
    });
  }

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
    await Provider.of<Posts>(context).fetchComments("id");
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Comments'),
        ),
        body: Consumer<Posts>(
            builder: (context, post, _) => Container(
                child: loading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : post.commentList.length == 0
                        ? Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: Text(
                              'No Comments Added.',
                              style: TextStyle(fontSize: 20),
                              textAlign: TextAlign.center,
                            )),
                          )
                        : ListView.builder(
                            itemCount: min(30, post.commentList.length),
                            itemBuilder: (context, item) {
                              return CommentWidget(
                                username: post.commentList[item]["username"],
                                comments: post.commentList[item]["comments"],
                              );
                            }))));
  }
}
