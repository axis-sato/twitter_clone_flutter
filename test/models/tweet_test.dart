import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

void main() {
  final user = User(
    id: 1,
    name: "鈴木 一郎",
    icon: "https://example.com/icon/1",
    profile: "鈴木 一郎です。",
    isFollower: false,
    followeeCount: 5,
  );

  final userJsonString = '''
  {"id": ${user.id}, "name": "${user.name}", "icon": "${user.icon}", "profile": "${user.profile}", "is_follower": ${user.isFollower}, "followee_count": ${user.followeeCount}}
  ''';

  final now = DateTime.now();

  group('Tweet Class Test', () {
    test('Init', () {
      final tweet = Tweet(
        id: 1,
        tweet: 'ツイート',
        createdAt: now,
        user: user,
        like: 5,
        isLiked: true,
      );

      expect(tweet.id, 1);
      expect(tweet.tweet, 'ツイート');
      expect(tweet.createdAt, now);
      expect(tweet.user, user);
      expect(tweet.like, 5);
      expect(tweet.isLiked, true);
    });

    test('Init fromJson', () {
      final jsonString =
          '''{"id": 1, "tweet": "ツイート", "created_at": "${now.toString()}", "user": $userJsonString, "like": 5, "is_liked": true}''';
      final json = jsonDecode(jsonString);

      final tweet = Tweet.fromJson(json);

      expect(tweet.id, 1);
      expect(tweet.tweet, 'ツイート');
      expect(tweet.createdAt, now);
      expect(tweet.user, user);
      expect(tweet.like, 5);
      expect(tweet.isLiked, true);
    });
  });

  group('Tweets Class Test', () {
    final tweet1 = Tweet(
      id: 1,
      tweet: 'ツイート1',
      createdAt: now,
      user: user,
      like: 5,
      isLiked: true,
    );
    final tweet2 = Tweet(
      id: 2,
      tweet: 'ツイート2',
      createdAt: now,
      user: user,
      like: 10,
      isLiked: false,
    );

    test('Init', () {
      final tweets = Tweets(tweets: [tweet1, tweet2], containsFirstTweet: true);

      expect(tweets.tweets, [tweet1, tweet2]);
      expect(tweets.containsFirstTweet, true);
    });

    test('Init fromJson', () {
      final jsonString =
          '''{"tweets": [{"id": 1, "tweet": "ツイート1", "created_at": "${now.toString()}", "user": $userJsonString, "like": 5, "is_liked": true}, {"id": 2, "tweet": "ツイート2", "created_at": "${now.toString()}", "user": $userJsonString, "like": 10, "is_liked": false}], "contains_first_tweet": true}''';
      final json = jsonDecode(jsonString);

      final tweets = Tweets.fromJson(json);

      expect(tweets.tweets, [tweet1, tweet2]);
      expect(tweets.containsFirstTweet, true);
    });

    test('copyWith', () {
      final tweets = Tweets(tweets: [tweet1, tweet2], containsFirstTweet: true);

      // tweetsのみ変更
      final newTweets1 = tweets.copyWith(tweets: [tweet1]);
      expect(newTweets1.tweets, [tweet1]);
      expect(newTweets1.containsFirstTweet, true);
      expect(newTweets1, isNot(equals(tweets)));

      // containsFirstTweetのみ変更
      final newTweets2 = tweets.copyWith(containsFirstTweet: false);
      expect(newTweets2.tweets, [tweet1, tweet2]);
      expect(newTweets2.containsFirstTweet, false);
      expect(newTweets2, isNot(equals(tweets)));

      // tweetsとcontainsFirstTweetどちらも変更
      final newTweets3 =
          tweets.copyWith(tweets: [tweet1], containsFirstTweet: false);
      expect(newTweets3.tweets, [tweet1]);
      expect(newTweets3.containsFirstTweet, false);
      expect(newTweets3, isNot(equals(tweets)));
    });
  });
}
