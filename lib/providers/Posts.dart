import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Posts with ChangeNotifier {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static const _baseUrl =
      "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas";
  List _Posts = [];
  List _bookMarkedPosts = [];
  List get postsList {
    return [..._Posts];
  }

  bool isBookmarked(String id) {
    for (var p in _bookMarkedPosts) {
      if (p["id"] == id) return true;
    }
    return false;
  }

  List get bookMarkedPosts {
    return [..._bookMarkedPosts];
  }

  Future<void> fetchBookmarkedPosts() async {
    final SharedPreferences prefs = await _prefs;
    String? posts = prefs.getString('bookmarkedPosts');
    if (posts != null) {
      _bookMarkedPosts = jsonDecode(posts);
    }
    notifyListeners();
  }

  Future<void> bookmark(Map post) async {
    final SharedPreferences prefs = await _prefs;
    _bookMarkedPosts.add(post);
    prefs.setString('bookmarkedPosts', jsonEncode(_bookMarkedPosts));
    notifyListeners();
  }

  Future<void> removeBookmark(String id) async {
    final SharedPreferences prefs = await _prefs;
    int index = 0;
    for (var p in _bookMarkedPosts) {
      if (p["id"] == id) break;
      index++;
    }
    _bookMarkedPosts.removeAt(index);
    prefs.setString('bookmarkedPosts', jsonEncode(_bookMarkedPosts));
    notifyListeners();
  }

  Future<void> fetchPosts() async {
    try {
      http.Response r = await http.get(Uri.parse(_baseUrl), headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
      });
      _Posts = json.decode(r.body);
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
