import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitter_clone_flutter/core/models/tweet.dart';

class Api {
  static const _endpoint = 'http://localhost:1323/api/v1';

  final _client = http.Client();

  Future<Tweets> fetchTweets() async {
    final response = await _client.get('$_endpoint/tweets');
    final tweetsJson = json.decode(response.body);
    return Tweets.fromJson(tweetsJson);
  }
}
