import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/ui/screens/post_tweet/post_tweet_view_model.dart';
import '../../../core/services/mock.dart';

void main() {
  test('postTweet', () async {
    final tweetService = MockTweetService();
    when(tweetService.postTweet('foo'))
        .thenAnswer((_) => Future.value(Tweet(id: 1, tweet: 'foo')));

    final vm = PostTweetViewModel(tweetService: tweetService);

    final tweet = await vm.postTweet('foo');
    expect(tweet.tweet, 'foo');
  });
}
