import 'dart:io';

import 'package:http/http.dart';
import 'package:twitter_clone_flutter/core/infra/api.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';

class UserService {
  Api api;

  Future<Users> getUsers(int maxId, int minId, int limit) async {
    try {
      return await api.fetchUsers(maxId, minId, limit);
    } on SocketException {
      throw Failure('ネットワークに接続できませんでした。');
    } on ClientException {
      throw Failure('ネットワークに接続できませんでした。');
    } on HttpException {
      throw Failure('ツイートの取得に失敗しました。');
    } on FormatException {
      throw Failure('Bad response format.');
    }
  }
}
