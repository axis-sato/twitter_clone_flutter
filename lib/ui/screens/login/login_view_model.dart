import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:twitter_clone_flutter/core/services/authentication_service.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/view_model.dart';

class LoginViewModel extends ViewModel {
  final AuthenticationService _authenticationService;

  LoginViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<FirebaseUser> handleSingInWithGoogle() {
    return _authenticationService.signInWithGoogle();
  }
}
