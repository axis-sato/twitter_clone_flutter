import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/utils/app_constants.dart';
import 'package:twitter_clone_flutter/ui/screens/home_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/post_tweet/post_tweet_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet/tweet_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet/tweet_screen_arguments.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/user_list/user_list_screen.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case RoutePaths.TweetList:
        final key = PageStorageKey<String>('tweet_list');
        return MaterialPageRoute(
          builder: (_) => TweetListScreen(key: key),
        );
      case RoutePaths.Tweet:
        final args = settings.arguments as TweetScreenArguments;
        return MaterialPageRoute(
          builder: (context) =>
              TweetScreen.create(context, args.tweet, args.vm),
        );
      case RoutePaths.PostTweet:
        return MaterialPageRoute(
          builder: (context) => PostTweetScreen.create(context),
          fullscreenDialog: true,
        );
      case RoutePaths.UserList:
        return MaterialPageRoute(
          builder: (context) => UserListScreen.create(context),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
