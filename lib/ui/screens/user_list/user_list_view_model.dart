import 'package:flutter/cupertino.dart';
import 'package:twitter_clone_flutter/core/services/user_service.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/ViewModel.dart';

class UserListViewModel extends ViewModel {
  final UserService _userService;

  UserListViewModel({@required UserService userService})
      : _userService = userService;

  void init() {
    debugPrint('UserListViewModel init');
  }
}
