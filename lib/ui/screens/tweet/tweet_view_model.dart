import 'package:flutter/cupertino.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_view_model.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/view_model.dart';

class TweetViewModel extends ViewModel {
  final TweetService _tweetService;
  final TweetListViewModel _tweetListViewModel;

  Tweet _tweet;
  Tweet get tweet => _tweet;
  void _setTweet(Tweet tweet) {
    _tweet = tweet;
    notifyListeners();
  }

  TweetViewModel(
      {@required TweetService tweetService,
      @required TweetListViewModel tweetListViewModel,
      @required Tweet tweet})
      : _tweetService = tweetService,
        _tweetListViewModel = tweetListViewModel,
        _tweet = tweet;

  void like(int tweetId) async {
    final tweet = await _tweetService.like(tweetId);
    _updateTweet(tweet);
  }

  void unlike(int tweetId) async {
    final tweet = await _tweetService.unlike(tweetId);
    _updateTweet(tweet);
  }

  void _updateTweet(Tweet tweet) {
    _setTweet(tweet);
    _tweetListViewModel.updateTweet(tweet);
  }
}
