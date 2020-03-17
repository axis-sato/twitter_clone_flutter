import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

class Api {
  final String _endpoint;
  final _client = http.Client();

  Api({String endpoint = 'http://localhost:1323/api/v1'})
      : _endpoint = endpoint;

  Future<Tweets> fetchTweets(int maxId, int minId, int limit) async {
    var qs = '';

    if (maxId != null) {
      final s = _querySeparator(qs);
      qs += '${s}max_id=$maxId';
    }
    if (minId != null) {
      final s = _querySeparator(qs);
      qs += '${s}min_id=$minId';
    }
    if (limit != null) {
      final s = _querySeparator(qs);
      qs += '${s}limit=$limit';
    }

    final url = '$_endpoint/tweets$qs';

    final response = await _client.get(url);
    final tweetsJson = json.decode(response.body);
    return Tweets.fromJson(tweetsJson);
  }

  Future<Tweet> postTweet(String tweet) async {
    final url = '$_endpoint/tweets';
    final body = {'tweet': tweet};
    final response = await _postJson(url, body: body);
    final tweetJson = json.decode(response.body);
    return Tweet.fromJson(tweetJson);
  }

  Future<Tweet> like(int tweetId) async {
    final url = '$_endpoint/tweets/$tweetId/like';
    final response = await _putJson(url);
    final tweetJson = json.decode(response.body);
    return Tweet.fromJson(tweetJson);
  }

  Future<Tweet> unlike(int tweetId) async {
    final url = '$_endpoint/tweets/$tweetId/unlike';
    final response = await _putJson(url);
    final tweetJson = json.decode(response.body);
    return Tweet.fromJson(tweetJson);
  }

  Future<Users> fetchUsers(int maxId, int minId, int limit) async {
    var qs = '';

    if (maxId != null) {
      final s = _querySeparator(qs);
      qs += '${s}max_id=$maxId';
    }
    if (minId != null) {
      final s = _querySeparator(qs);
      qs += '${s}min_id=$minId';
    }
    if (limit != null) {
      final s = _querySeparator(qs);
      qs += '${s}limit=$limit';
    }

    final url = '$_endpoint/users$qs';

    final response = await _client.get(url);
    final usersJson = json.decode(response.body);
    return Users.fromJson(usersJson);
  }

  String _querySeparator(String qs) {
    return qs == '' ? '?' : '&';
  }

  Future<Response> _postJson(url, {Object body}) {
    return _client.post(
      url,
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }

  Future<Response> _putJson(url, {Object body}) {
    return _client.put(
      url,
      body: json.encode(body),
      headers: {'Content-Type': 'application/json'},
    );
  }
}
