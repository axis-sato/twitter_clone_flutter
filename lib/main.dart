import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/infra/api.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/core/services/user_service.dart';
import 'package:twitter_clone_flutter/ui/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Api>(create: (_) => Api()),
        ProxyProvider<Api, TweetService>(
          create: (context) => TweetService(),
          update: (context, api, service) => service..api = api,
        ),
        ProxyProvider<Api, UserService>(
          create: (context) => UserService(),
          update: (context, api, service) => service..api = api,
        ),
      ],
      child: MaterialApp(
        title: 'ツイッタークローン',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            color: Colors.white,
            textTheme: TextTheme(
              title: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            iconTheme: IconThemeData(
              color: Colors.lightBlue,
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
