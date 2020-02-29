import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/view_model.dart';

class TweetModel extends ViewModel {
  final TweetService _tweetService;

  Tweet _tweet;
  Tweet get tweet => _tweet;
  void _setTweet(Tweet tweet) {
    _tweet = tweet;
    notifyListeners();
  }

  TweetModel({@required TweetService tweetService, @required Tweet tweet})
      : _tweetService = tweetService,
        _tweet = tweet;

  void like(int tweetId) async {
    final tweet = await _tweetService.like(tweetId);
    _setTweet(tweet);
  }

  void unlike(int tweetId) async {
    final tweet = await _tweetService.unlike(tweetId);
    _setTweet(tweet);
  }
}
