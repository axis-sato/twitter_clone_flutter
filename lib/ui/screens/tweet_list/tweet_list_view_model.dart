import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/repositories/tweet_repository.dart';

class TweetListViewModel extends ChangeNotifier {
  final TweetRepository _tweetRepository;
  Tweets _tweets;

  UnmodifiableListView<Tweet> get tweets =>
      UnmodifiableListView(_tweets == null ? [] : _tweets.tweets);
  bool get containsFirstTweet =>
      _tweets == null ? false : _tweets.containsFirstTweet;

  TweetListViewModel({@required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  void init() async {
    fetchTweets();
  }

  void fetchTweets() async {
    _tweets = await _tweetRepository.fetchTweets();
    notifyListeners();
  }
}
