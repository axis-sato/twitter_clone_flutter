import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/repositories/tweet_repository.dart';

class TweetViewModel extends ChangeNotifier {
  final TweetRepository _tweetRepository;
  List<Tweet> _tweets = [];

  UnmodifiableListView<Tweet> get tweets => UnmodifiableListView(_tweets);

  TweetViewModel({@required TweetRepository tweetRepository})
      : _tweetRepository = tweetRepository {
    this._tweets = this._tweetRepository.fetchTweets();
  }
}
