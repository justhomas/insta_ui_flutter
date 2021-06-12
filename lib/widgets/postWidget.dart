import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

Color iconColor = Colors.grey;

class PostWidget extends StatefulWidget {
  final String title;
  final String thumbnail;
  final String user_name;
  PostWidget(
      {required this.title, required this.thumbnail, required this.user_name});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  var _selection;
  late bool expanded;
  @override
  void initState() {
    setState(() {
      expanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    PopupMenuButton commentMenu = PopupMenuButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        decoration: BoxDecoration(shape: BoxShape.circle),
        child: Icon(
          Icons.more_vert_rounded,
          color: iconColor,
        ),
      ),
      onSelected: (result) {
        setState(() {
          _selection = result;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry>[
        PopupMenuItem(
          value: 'report',
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.flag_outlined,
                  color: iconColor,
                ),
              ),
              Text('Report User'),
            ],
          ),
        ),
      ],
    );

    return Container(
        margin: EdgeInsets.only(bottom: 5),
        color: Colors.white,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(widget.thumbnail)),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(widget.user_name),
              )),
              commentMenu,
            ],
          ),
          Image.network(widget.thumbnail),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
            child: Text(
              widget.user_name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          height: 1.3,
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold),
                      text: widget.user_name,
                      children: [
                    TextSpan(
                        text: widget.title.length > 50 && !expanded
                            ? " " + widget.title.substring(0, 50) + "..."
                            : " " + widget.title,
                        style: TextStyle(
                            height: 1.3,
                            color: Colors.black,
                            fontSize: 15,
                            letterSpacing: 1.2,
                            fontWeight: FontWeight.normal)),
                    widget.title.length > 50 && !expanded
                        ? TextSpan(
                            text: ' more',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  expanded = true;
                                });
                              })
                        : TextSpan()
                  ]))),
          Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              margin: EdgeInsets.only(top: 15),
              child: PostLikeCommentWidget())
        ]));
  }
}

class PostLikeCommentWidget extends StatefulWidget {
  @override
  _PostLikeCommentWidgetState createState() => _PostLikeCommentWidgetState();
}

class _PostLikeCommentWidgetState extends State<PostLikeCommentWidget> {
  late bool liked, disliked;
  late int noLikes, noDislikes, noComments;

  @override
  void initState() {
    super.initState();
    setState(() {
      liked = false;
      disliked = false;
      noLikes = new Random().nextInt(500);
      noDislikes = new Random().nextInt(4000);
      noComments = new Random().nextInt(5000);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    if (!liked) {
                      liked = true;
                      noLikes++;
                      if (disliked) {
                        disliked = false;
                        noDislikes--;
                      }
                    } else {
                      liked = false;
                      noLikes--;
                    }
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Icon(
                      liked ? Icons.thumb_up : Icons.thumb_up_outlined,
                      color: iconColor,
                    )),
              ),
              InkWell(
                onTap: () {
                  showModalBottomSheet<void>(
                    enableDrag: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    backgroundColor: Colors.white,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: EdgeInsets.all(15),
                        height: MediaQuery.of(context).size.height * 0.75,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Center(
                                  child: Container(
                                height: 8,
                                width: 100,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey),
                              )),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Icon(Icons.comment_outlined, color: iconColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.share_outlined, color: iconColor),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Icon(Icons.add_circle_outline, color: iconColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
