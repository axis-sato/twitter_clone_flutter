import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

class TweetRepository {
  List<Tweet> fetchTweets() {
    return List<Tweet>.generate(100, (i) {
      return Tweet(
        tweet: "ツイート $i",
        createdAt: DateTime.now(),
        user: User(
          name: "ユーザ${(i % 2) + 1}",
          icon: "assets/images/user${(i % 2) + 1}.png",
          profile: "ユーザ${i + 1}です。",
          isFollower: i % 2 == 1,
          followerCount: i,
        ),
        like: i,
        isLiked: i % 2 == 1,
      );
    });
  }
}
