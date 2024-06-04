import 'dart:convert';
import 'dart:developer';
import 'dart:io';

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
    } on SocketException catch (err) {
      throw Exception('No Internet Connection:${err.message}');
    } on HttpException catch (err) {
      throw Exception('HTTP error: ${err.message}');
    } catch (err) {
      throw Exception('Unexpected error: $err');
    }
  }

  Future<Welcome> getOne(int index) async {
    try {
      final response = await get((Uri.parse('$link/$index')));
      if (response.statusCode == 200) {
        return welcomeOneFromJson(response.body.toString());
      }
      return Welcome(userId: 0, id: 0, title: '', body: '');
    } on SocketException catch (err) {
      throw Exception('No Internet Connection:${err.message}');
    } on HttpException catch (err) {
      throw Exception('HTTP error: ${err.message}');
    } catch (err) {
      throw Exception('Unexpected error: $err');
    }
  }
}
