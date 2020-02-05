import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:twitter_clone_flutter/core/models/tweet.dart';

class Api {
  static const _endpoint = 'http://localhost:1323/api/v1';

  final _client = http.Client();

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
      qs += '${s}max_id=$maxId';
    }

    final url = '$_endpoint/tweets$qs';

    final response = await _client.get(url);
    final tweetsJson = json.decode(response.body);
    return Tweets.fromJson(tweetsJson);
  }

  String _querySeparator(String qs) {
    return qs == '' ? '?' : '&';
  }
}
