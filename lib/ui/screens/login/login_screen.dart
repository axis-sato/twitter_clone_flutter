import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/services/authentication_service.dart';
import 'package:twitter_clone_flutter/core/utils/app_constants.dart';
import 'package:twitter_clone_flutter/ui/screens/login/login_view_model.dart';

class LoginScreen extends StatelessWidget {
  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginViewModel(
        authenticationService:
            Provider.of<AuthenticationService>(context, listen: false),
      ),
      child: LoginScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ログイン'),
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, vm, child) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Text('Sign in Google'),
                  onPressed: () {
                    vm.handleSingInWithGoogle().then(
                          (user) => Navigator.pushNamed(
                            context,
                            RoutePaths.Home,
                          ),
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
