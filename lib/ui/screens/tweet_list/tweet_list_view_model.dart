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

  int get _firstTweetIdInTheList =>
      _tweets == null ? null : _tweets.tweets.first.id;

  int get _lastTweetIdInTheList =>
      _tweets == null ? null : _tweets.tweets.last.id;

  TweetListViewModel({@required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository;

  Future<void> init() async {
    loading = true;
    notifyListeners();
    _tweets = await _fetchTweetsAfter(null);
    loading = false;
    notifyListeners();
  }

  Future<void> fetchNewTweets() async {
    if (loading) {
      return;
    }
    loading = true;
    notifyListeners();
    final minId =
        _firstTweetIdInTheList == null ? null : _firstTweetIdInTheList + 1;
    final tweets = await _fetchTweetsBefore(minId);
    _tweets = _tweets == null
        ? tweets
        : _tweets.copyWith(tweets.tweets + _tweets.tweets, null);
    loading = false;
    notifyListeners();
  }

  Future<void> fetchMoreTweets() async {
    if (loading || hasReachedMax) {
      return;
    }
    loading = true;
    notifyListeners();
    final maxId =
        _lastTweetIdInTheList == null ? null : _lastTweetIdInTheList - 1;
    final tweets = await _fetchTweetsAfter(maxId);
    _tweets = _tweets == null
        ? tweets
        : _tweets.copyWith(
            _tweets.tweets + tweets.tweets,
            tweets.containsFirstTweet,
          );
    loading = false;
    notifyListeners();
  }

  Future<Tweets> _fetchTweetsAfter(int maxId) async {
    return _tweetRepository.fetchTweets(maxId, null, 10);
  }

  Future<Tweets> _fetchTweetsBefore(int minId) async {
    return _tweetRepository.fetchTweets(null, minId, null);
  }
}
