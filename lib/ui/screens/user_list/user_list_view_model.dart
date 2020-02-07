import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/core/services/user_service.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/ViewModel.dart';

class UserListViewModel extends ViewModel {
  final UserService _userService;

  bool _bottomLoading = false;
  bool get bottomLoading => _bottomLoading;
  void _setBottomLoading(bool loading) {
    _bottomLoading = loading;
//    notifyListeners();
  }

  Users _users;
  UnmodifiableListView<User> get users =>
      UnmodifiableListView(_users == null ? [] : _users.users);
  void _setUsers(Users users) {
    _users = users;
    notifyListeners();
  }

  bool get _hasReachedMax => _users == null ? false : _users.containsFirstUser;
  int get _firstUserIdInTheList =>
      _users == null ? null : _users.users.first.id;
  int get _lastUserIdInTheList => _users == null ? null : _users.users.last.id;

  Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  }

  UserListViewModel({@required UserService userService})
      : _userService = userService;

  void init() async {
    setLoading(true);
    await _getUsersAfter(null);
    setLoading(false);
  }

  Future<void> getNewUsers() async {
    if (bottomLoading) {
      return;
    }
    _setBottomLoading(true);
    final minId =
        _firstUserIdInTheList == null ? null : _firstUserIdInTheList + 1;
    await _getUsersBefore(minId);
    _setBottomLoading(false);
  }

  Future<void> getMoreUsers() async {
    if (bottomLoading || _hasReachedMax) {
      return;
    }
    _setBottomLoading(true);
    final maxId =
        _lastUserIdInTheList == null ? null : _lastUserIdInTheList - 1;
    await _getUsersAfter(maxId);
    _setBottomLoading(false);
  }

  Future<void> _getUsersAfter(int maxId) async {
    try {
      final users = await _userService.getUsers(maxId, null, 10);
      _setUsers(
        _users == null
            ? users
            : _users.copyWith(
                _users.users + users.users,
                users.containsFirstUser,
              ),
      );
    } on Failure catch (f) {
      _setFailure(f);
      debugPrint(f.message);
    }
  }

  Future<void> _getUsersBefore(int minId) async {
    try {
      final users = await _userService.getUsers(null, minId, null);
      _setUsers(
        _users == null
            ? users
            : _users.copyWith(users.users + _users.users, null),
      );
    } on Failure catch (f) {
      _setFailure(f);
      debugPrint(f.message);
    }
  }
}
