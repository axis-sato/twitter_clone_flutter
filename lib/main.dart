import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/utils/app_constants.dart';
import 'package:twitter_clone_flutter/provider_setup.dart';
import 'package:twitter_clone_flutter/ui/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
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
        initialRoute: RoutePaths.Home,
        onGenerateRoute: Router.generateRoute,
      ),
    );
  }
}
