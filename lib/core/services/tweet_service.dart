import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:twitter_clone_flutter/core/infra/api.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';

class TweetService {
  Api api;

  Future<Tweets> getTweets(int maxId, int minId, int limit) async {
    try {
      return await api.fetchTweets(maxId, minId, limit);
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

  Future<Tweet> postTweet(String tweet) async {
    try {
      return await api.postTweet(tweet);
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
