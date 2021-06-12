import 'dart:ui';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_flutter/providers/Posts.dart';
import 'package:insta_flutter/screens/comments.dart';
import 'package:provider/provider.dart';

Color iconColor = Colors.grey;

class PostWidget extends StatefulWidget {
  final String title;
  final String thumbnail;
  final String userName;
  final String id;
  PostWidget(
      {required this.title,
      required this.thumbnail,
      required this.userName,
      required this.id});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  var _selection;
  late bool expanded, liked;
  @override
  void initState() {
    setState(() {
      expanded = false;
      liked = false;
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
                child: FaIcon(
                  FontAwesomeIcons.flag,
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
                child: Text(widget.userName),
              )),
              commentMenu,
            ],
          ),
          Image.network(widget.thumbnail),
          Container(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
              child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          height: 1.3,
                          color: Colors.black,
                          fontSize: 15,
                          letterSpacing: 1.2,
                          fontWeight: FontWeight.bold),
                      text: widget.userName,
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
                          } else {
                            liked = false;
                          }
                        });
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: FaIcon(
                            liked
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: iconColor,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => CommentsScreen()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child:
                            FaIcon(FontAwesomeIcons.comment, color: iconColor),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child:
                          FaIcon(FontAwesomeIcons.paperPlane, color: iconColor),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                        onTap: () {
                          Provider.of<Posts>(context, listen: false)
                                  .isBookmarked(widget.id)
                              ? Provider.of<Posts>(context, listen: false)
                                  .removeBookmark(widget.id)
                              : Provider.of<Posts>(context, listen: false)
                                  .bookmark({
                                  "id": widget.id,
                                  "title": widget.title,
                                  "channelname": widget.userName,
                                  "high thumbnail": widget.thumbnail
                                });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: FaIcon(
                              Provider.of<Posts>(context, listen: false)
                                      .isBookmarked(widget.id)
                                  ? FontAwesomeIcons.solidBookmark
                                  : FontAwesomeIcons.bookmark,
                              color: iconColor),
                        )),
                  ],
                ),
              ],
            ),
          )
        ]));
  }
}
