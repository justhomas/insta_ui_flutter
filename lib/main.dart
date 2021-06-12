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
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    icon: FaIcon(FontAwesomeIcons.instagram), onPressed: () {}),
                leadingWidth: 25,
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: FaIcon(
                      FontAwesomeIcons.telegramPlane,
                      color: Colors.white,
                    ),
                  )
                ],
                title: Text('Instagram'),
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
                          color: currentPage == 0 ? Colors.blue : Colors.grey),
                      label: 'Home'),
                  BottomNavigationBarItem(
                      icon: FaIcon(FontAwesomeIcons.solidBookmark,
                          color: currentPage == 1 ? Colors.blue : Colors.grey),
                      label: 'Bookmarks'),
                ],
              ))),
    );
  }
}
