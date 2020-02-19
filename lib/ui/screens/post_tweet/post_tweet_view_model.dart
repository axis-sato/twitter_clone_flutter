import 'package:flutter/cupertino.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/ViewModel.dart';

class PostTweetViewModel extends ViewModel {
  final TweetService _tweetService;

  PostTweetViewModel({@required TweetService tweetService})
      : _tweetService = tweetService;

  void postTweet(String tweet) async {
    final t = await _tweetService.postTweet(tweet);
    print(t);
  }
}
