import 'dart:io';

import 'package:http/http.dart';
import 'package:twitter_clone_flutter/core/infra/api.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';

class TweetService {
  Api api;

  Future<Tweets> getTweets(int maxId, int minId, int limit) async {
    return _request(api.fetchTweets(maxId, minId, limit));
  }

  Future<Tweet> postTweet(String tweet) async {
    return _request(api.postTweet(tweet));
  }

  Future<Tweet> like(int tweetId) async {
    return _request(api.like(tweetId));
  }

  Future<Tweet> unlike(int tweetId) async {
    return _request(api.unlike(tweetId));
  }

  Future<T> _request<T>(Future<T> f) async {
    try {
      return await f;
    } on SocketException {
      throw Failure('ネットワークに接続できませんでした。');
    } on ClientException {
      throw Failure('ネットワークに接続できませんでした。');
    } on HttpException {
      throw Failure('ツイートの取得に失敗しました。');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }
}
