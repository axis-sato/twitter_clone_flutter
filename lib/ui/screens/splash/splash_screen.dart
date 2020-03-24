import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/services/authentication_service.dart';
import 'package:twitter_clone_flutter/core/utils/app_constants.dart';
import 'package:twitter_clone_flutter/ui/screens/splash/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SplashViewModel(
        authenticationService:
            Provider.of<AuthenticationService>(context, listen: false),
      ),
      child: SplashScreen(),
    );
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<SplashViewModel>(context, listen: false).currentUser.then(
          (user) => Navigator.pushNamed(
              context, user == null ? RoutePaths.Login : RoutePaths.Home),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text('スプラッシュ'),
      ),
    );
  }
}
