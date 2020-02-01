import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/data/api.dart';
import 'package:twitter_clone_flutter/core/repositories/tweet_repository.dart';
import 'package:twitter_clone_flutter/ui/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Api>(create: (_) => Api()),
        ProxyProvider<Api, TweetRepository>(
          create: (context) => TweetRepository(),
          update: (context, api, repository) => repository..api = api,
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
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
