import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:twitter_clone_flutter/core/models/tweet.dart';

class Api {
  static const _endpoint = 'http://localhost:1323/api/v1';

  final _client = http.Client();

  Future<Tweets> fetchTweets(int lastId, int limit) async {
    var url = '$_endpoint/tweets?limit=$limit';
    if (lastId != null) {
      url += '&last_id=$lastId';
    }

    final response = await _client.get(url);
    final tweetsJson = json.decode(response.body);
    return Tweets.fromJson(tweetsJson);
  }
}
