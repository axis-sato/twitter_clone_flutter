import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/services/authentication_service.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/view_model.dart';

class SplashViewModel extends ViewModel {
  final AuthenticationService _authenticationService;

  SplashViewModel({@required AuthenticationService authenticationService})
      : _authenticationService = authenticationService;

  Future<FirebaseUser> get currentUser => _authenticationService.currentUser;
}
