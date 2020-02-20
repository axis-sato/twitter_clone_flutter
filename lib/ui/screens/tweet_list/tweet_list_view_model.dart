import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/ViewModel.dart';

class TweetListViewModel extends ViewModel {
  final TweetService _tweetService;

  bool _bottomLoading = false;
  bool get bottomLoading => _bottomLoading;
  void _setBottomLoading(bool loading) {
    _bottomLoading = loading;
//    notifyListeners();
  }

  Tweets _tweets;
  UnmodifiableListView<Tweet> get tweets =>
      UnmodifiableListView(_tweets == null ? [] : _tweets.tweets);
  void _setTweets(Tweets tweets) {
    _tweets = tweets;
    notifyListeners();
  }

  bool get _hasReachedMax =>
      _tweets == null ? false : _tweets.containsFirstTweet;
  int get _firstTweetIdInTheList =>
      _tweets == null ? null : _tweets.tweets.first.id;
  int get _lastTweetIdInTheList =>
      _tweets == null ? null : _tweets.tweets.last.id;

  Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  TweetListViewModel({@required TweetService tweetService})
      : _tweetService = tweetService;

  void init() async {
    setLoading(true);
    await _getTweetsAfter(null);
    setLoading(false);
  }

  Future<void> getNewTweets() async {
    if (loading || bottomLoading) {
      return;
    }
    _setBottomLoading(true);
    final minId =
        _firstTweetIdInTheList == null ? null : _firstTweetIdInTheList + 1;
    await _getTweetsBefore(minId);
    _setBottomLoading(false);
  }

  Future<void> getMoreTweets() async {
    if (loading || bottomLoading || _hasReachedMax) {
      return;
    }
    _setBottomLoading(true);
    final maxId =
        _lastTweetIdInTheList == null ? null : _lastTweetIdInTheList - 1;
    await _getTweetsAfter(maxId);
    _setBottomLoading(false);
  }

  Future<void> _getTweetsAfter(int maxId) async {
    try {
      final tweets = await _tweetService.getTweets(maxId, null, 10);
      _setTweets(
        _tweets == null
            ? tweets
            : _tweets.copyWith(
                tweets: _tweets.tweets + tweets.tweets,
                containsFirstTweet: tweets.containsFirstTweet,
              ),
      );
    } on Failure catch (f) {
      _setFailure(f);
      debugPrint(f.message);
    }
  }

  Future<void> _getTweetsBefore(int minId) async {
    try {
      final tweets = await _tweetService.getTweets(null, minId, null);
      _setTweets(
        _tweets == null
            ? tweets
            : _tweets.copyWith(tweets: tweets.tweets + _tweets.tweets),
      );
    } on Failure catch (f) {
      _setFailure(f);
      debugPrint(f.message);
    }
  }

  void unshiftTweet(Tweet tweet) {
    _setTweets(
      _tweets == null
          ? [tweet]
          : _tweets.copyWith(
              tweets: [tweet] + _tweets.tweets,
            ),
    );
    notifyListeners();
  }
}
