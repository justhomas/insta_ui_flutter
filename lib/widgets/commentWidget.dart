import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:insta_flutter/providers/Posts.dart';
import 'package:provider/provider.dart';

Color iconColor = Colors.grey;

class CommentWidget extends StatefulWidget {
  String username, comments;
  CommentWidget({required this.username, required this.comments});
  @override
  _CommentWidgetState createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late bool expanded, init, loading;

  var _selection;
  @override
  void initState() {
    super.initState();
    setState(() {
      expanded = false;
      init = false;
      loading = true;
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
      padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: CircleAvatar(
                radius: 15,
                backgroundImage:
                    NetworkImage("https://via.placeholder.com/150")),
          ),
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                      child: Text(
                        widget.username,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                        child: Container(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 8, 4),
                      child: commentMenu,
                    )
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(right: 8),
                  child: widget.comments.length > 100 && !expanded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                              Text(
                                widget.comments.substring(0, 100) + '...',
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: InkWell(
                                  child: Text('Read More'),
                                  onTap: () {
                                    setState(() {
                                      expanded = true;
                                    });
                                  },
                                ),
                              )
                            ])
                      : Text(
                          widget.comments,
                        ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
