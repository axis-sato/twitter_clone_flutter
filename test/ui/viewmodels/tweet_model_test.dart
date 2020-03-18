import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/tweet_model.dart';
import '../../core/services/mock.dart';

void main() {
  test('like', () {
    // Setup
    final tweet = Tweet(id: 1, isLiked: false);
    final tweetService = MockTweetService();
    when(tweetService.like(1))
        .thenAnswer((_) => Future.value(Tweet(id: 1, isLiked: true)));

    final vm = TweetModel(tweetService: tweetService, tweet: tweet);

    vm.addListener(() {
      expect(vm.tweet.isLiked, true);
    });
    vm.like(1);
  });

  test('unlike', () {
    // Setup
    final tweet = Tweet(id: 1, isLiked: true);
    final tweetService = MockTweetService();
    when(tweetService.unlike(1))
        .thenAnswer((_) => Future.value(Tweet(id: 1, isLiked: false)));

    final vm = TweetModel(tweetService: tweetService, tweet: tweet);

    vm.addListener(() {
      expect(vm.tweet.isLiked, false);
    });
    vm.unlike(1);
  });
}
