import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/tweet_model.dart';

class TweetScreenArguments {
  final Tweet tweet;
  final TweetModel vm;

  TweetScreenArguments(this.tweet, this.vm);
}
