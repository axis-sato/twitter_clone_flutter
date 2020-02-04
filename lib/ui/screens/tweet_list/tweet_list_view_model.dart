import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/repositories/tweet_repository.dart';

class TweetListViewModel extends ChangeNotifier {
  final TweetRepository _tweetRepository;
  Tweets _tweets;
  bool loading = false;

  UnmodifiableListView<Tweet> get tweets =>
      UnmodifiableListView(_tweets == null ? [] : _tweets.tweets);

  bool get hasReachedMax =>
      _tweets == null ? false : _tweets.containsFirstTweet;

  int get _lastTweetIdInTheList =>
      _tweets == null ? null : _tweets.tweets.last.id;

  TweetListViewModel({@required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  void init() async {
    loading = true;
    notifyListeners();
    _tweets = await _fetchTweets(null);
    loading = false;
    notifyListeners();
  }

  void moreTweets() async {
    if (loading || hasReachedMax) {
      return;
    }
    loading = true;
    notifyListeners();
    final lastTweetIdInTheList =
        _lastTweetIdInTheList == null ? null : _lastTweetIdInTheList - 1;
    final tweets = await _fetchTweets(lastTweetIdInTheList);
    _tweets = _tweets == null
        ? tweets
        : _tweets.copyWith(
            _tweets.tweets + tweets.tweets, tweets.containsFirstTweet);
    loading = false;
    notifyListeners();
  }

  Future<Tweets> _fetchTweets(int lastId) async {
    return _tweetRepository.fetchTweets(lastId, 10);
  }
}
