import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:twitter_clone_flutter/core/infra/api.dart';
import 'package:twitter_clone_flutter/core/services/authentication_service.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/core/services/user_service.dart';

List<SingleChildWidget> providers = [
  ..._infra,
  ..._services,
];

List<SingleChildWidget> _infra = [
  Provider<Api>(create: (_) => Api()),
];

List<SingleChildWidget> _services = [
  Provider(
    create: (_) => AuthenticationService(),
  ),
  ProxyProvider<Api, TweetService>(
    create: (context) => TweetService(),
    update: (context, api, service) => service..api = api,
  ),
  ProxyProvider<Api, UserService>(
    create: (context) => UserService(),
    update: (context, api, service) => service..api = api,
  ),
];
