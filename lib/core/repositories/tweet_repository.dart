import 'package:twitter_clone_flutter/core/data/api.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';

class TweetRepository {
  Api api;

  Future<Tweets> fetchTweets(int maxId, int minId, int limit) async {
    return await api.fetchTweets(maxId, minId, limit);
  }
}
