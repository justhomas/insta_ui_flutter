import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

Color iconColor = Colors.grey;

class PostWidget extends StatefulWidget {
  final String title;
  PostWidget({required this.title});
  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  var _selection;

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
          value: 'harder',
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.outlet,
                  color: iconColor,
                ),
              ),
              Text('Valare moshavayi poyi'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'smarter',
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.menu,
                  color: iconColor,
                ),
              ),
              Text('Ingane commentidatada'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'selfStarter',
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.ac_unit,
                  color: iconColor,
                ),
              ),
              Text('Enna oola commentada'),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'tradingCharter',
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
                    radius: 25, backgroundImage: NetworkImage(widget.title)),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text('Prithviraj Sukumaran'),
              )),
              commentMenu,
            ],
          ),
          Stack(
            children: [
              Image.network(
                  'https://cdn.pixabay.com/photo/2017/08/30/01/05/milky-way-2695569_960_720.jpg'),
              Positioned(
                  bottom: 10,
                  left: 10,
                  child: Icon(
                    Icons.headset_outlined,
                    color: Colors.white,
                    size: 30,
                  )),
              Positioned(
                  right: 10,
                  bottom: 10,
                  child: Text(
                    'Now Playing',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 8),
            child: Text(
              'Padam Vanamalli',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: Text(
              'Present Padam vanamali Song form Kakakuayil 4k Remastered zversion From movie Kakkakuyil',
              style: TextStyle(height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 8, 15, 0),
            child: Row(
              children: [
                Icon(
                  Icons.timelapse_outlined,
                  color: iconColor,
                  size: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text('19:36'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.lock_clock,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text('3 days ago'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(
                    Icons.play_arrow,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text('169K'),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              margin: EdgeInsets.only(top: 15),
              decoration: BoxDecoration(border: Border(top: BorderSide())),
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
      child: Row(
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
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(noLikes.toString()),
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (!disliked) {
                  disliked = true;
                  noDislikes++;
                  if (liked) {
                    liked = false;
                    noLikes--;
                  }
                } else {
                  disliked = false;
                  noDislikes--;
                }
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Icon(
                  disliked ? Icons.thumb_down : Icons.thumb_down_outlined,
                  color: iconColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(noDislikes.toString()),
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
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(Icons.add_circle_outline, color: iconColor),
          ),
        ],
      ),
    );
  }
}
