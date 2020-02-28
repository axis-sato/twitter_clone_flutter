import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_view_model.dart';

class TweetScreenArguments {
  final Tweet tweet;
  final TweetListViewModel vm;

  TweetScreenArguments(this.tweet, this.vm);
}
