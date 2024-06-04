import 'dart:convert';
import 'dart:developer';

import 'package:api_youtube/models/model_class.dart';
import 'package:http/http.dart';

class HttpConnection {
  String link = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Welcome>> getData() async {
    try {
      final response = await get(Uri.parse(link));
      if (response.statusCode == 200) {
        return welcomeFromJson(response.body.toString());
      }
      return [];
    } catch (err) {
      log('ERROR :$err');
      return [];
    }
  }

  Future<Welcome> getOne(int index) async {
    final response = await get(Uri.parse('$link/$index'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return Welcome.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
