import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:insta_flutter/providers/Posts.dart';
import 'package:insta_flutter/screens/bookmarks.dart';
import 'package:insta_flutter/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  List<Widget> _children = [MyHomePage(title: 'Instagram'), BookmarksPage()];
  List<String> _title = ['home', 'bookmarks'];
  List<Icon> _icon = [
    Icon(Icons.home),
    Icon(Icons.person_pin_circle),
    Icon(Icons.record_voice_over_outlined)
  ];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) {
        return Posts();
      },
      child: MaterialApp(
          title: 'Insta',
          theme: ThemeData(primaryColor: Colors.black),
          home: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagram,
                      color: Colors.black,
                    ),
                    onPressed: () {}),
                leadingWidth: 25,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.telegramPlane,
                      color: Colors.black,
                    ),
                  )
                ],
                title: Text(
                  'Instagram',
                  style: TextStyle(color: Colors.black),
                ),
              ),
              body: _children[currentPage],
              bottomNavigationBar: BottomNavigationBar(
                onTap: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                type: BottomNavigationBarType.fixed,
                currentIndex: currentPage,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.home,
                          color: currentPage == 0
                              ? Colors.black
                              : Colors.grey[400]),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.solidBookmark,
                          color: currentPage == 1
                              ? Colors.black
                              : Colors.grey[400]),
                      label: 'Bookmarks'),
                ],
              ))),
    );
  }
}
