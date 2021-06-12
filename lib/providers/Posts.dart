import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Posts with ChangeNotifier {
  static const _baseUrl =
      "https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas";
  List _Posts = [];

  List get postsList {
    return [..._Posts];
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
