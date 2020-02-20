import 'package:flutter/cupertino.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/ViewModel.dart';

class PostTweetViewModel extends ViewModel {
  final TweetService _tweetService;

  PostTweetViewModel({@required TweetService tweetService})
      : _tweetService = tweetService;

  Future<Tweet> postTweet(String tweet) async {
    return _tweetService.postTweet(tweet);
  }
}
