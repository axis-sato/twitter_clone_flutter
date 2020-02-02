import 'package:twitter_clone_flutter/core/models/user.dart';

class Tweets {
  final List<Tweet> tweets;
  final bool containsFirstTweet;

  const Tweets({this.tweets, this.containsFirstTweet});

  static Tweets fromJson(dynamic json) {
    final tweets = (json['tweets'] as List<dynamic>)
        .map((tweet) => Tweet.fromJson(tweet))
        .toList();
    return Tweets(
      tweets: tweets,
      containsFirstTweet: json['contains_first_tweet'],
    );
  }

  Tweets copyWith(List<Tweet> tweets, bool containsFirstTweet) {
    return Tweets(
      tweets: tweets ?? this.tweets,
      containsFirstTweet: containsFirstTweet ?? this.containsFirstTweet,
    );
  }
}

class Tweet {
  final int id;
  final String tweet;
  final DateTime createdAt;
  final User user;
  final int like;
  final bool isLiked;

  const Tweet({
    this.id,
    this.tweet,
    this.createdAt,
    this.user,
    this.like,
    this.isLiked,
  });

  static Tweet fromJson(dynamic json) {
    final user = User.fromJson(json['user']);
    return Tweet(
      id: json['id'],
      tweet: json['tweet'],
      createdAt: DateTime.parse(json['created_at']),
      user: user,
      like: json['like'],
      isLiked: json['is_liked'],
    );
  }
}
