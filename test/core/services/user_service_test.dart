import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/core/services/user_service.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';

import '../infra/mock.dart';

void main() {
  group('getUsers', () {
    test('ユーザ一覧取得', () async {
      final api = MockApi();
      final users = Users(
        users: [
          User(
            id: 1,
            name: 'foo',
            icon: 'bar',
            profile: 'hoge',
            isFollower: false,
            followeeCount: 5,
          ),
        ],
        containsFirstUser: true,
      );
      when(api.fetchUsers(100, 1, 100))
          .thenAnswer((_) async => Future.value(users));
      final userService = UserService()..api = api;
      final actual = await userService.getUsers(100, 1, 100);
      expect(actual, users);
    });

    test('SocketException', () async {
      final api = MockApi();
      when(api.fetchUsers(100, 1, 100)).thenThrow(
        SocketException("foo"),
      );
      final userService = UserService()..api = api;
      try {
        await userService.getUsers(100, 1, 100);
      } catch (e) {
        expect(
          e,
          Failure('ネットワークに接続できませんでした。'),
        );
      }
    });

    test('ClientException', () async {
      final api = MockApi();
      when(api.fetchUsers(100, 1, 100)).thenThrow(
        ClientException("foo"),
      );
      final userService = UserService()..api = api;
      try {
        await userService.getUsers(100, 1, 100);
      } catch (e) {
        expect(
          e,
          Failure('ネットワークに接続できませんでした。'),
        );
      }
    });

    test('HttpException', () async {
      final api = MockApi();
      when(api.fetchUsers(100, 1, 100)).thenThrow(
        HttpException("foo"),
      );
      final userService = UserService()..api = api;
      try {
        await userService.getUsers(100, 1, 100);
      } catch (e) {
        expect(
          e,
          Failure('ツイートの取得に失敗しました。'),
        );
      }
    });

    test('FormatException', () async {
      final api = MockApi();
      when(api.fetchUsers(100, 1, 100)).thenThrow(
        FormatException("foo"),
      );
      final userService = UserService()..api = api;
      try {
        await userService.getUsers(100, 1, 100);
      } catch (e) {
        expect(
          e,
          Failure('Bad response format.'),
        );
      }
    });
  });
}
