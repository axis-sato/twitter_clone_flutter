import 'package:twitter_clone_flutter/core/models/user.dart';

class Tweet {
  final String tweet;
  final DateTime createdAt;
  final User user;

  const Tweet({this.tweet, this.createdAt, this.user});
}
