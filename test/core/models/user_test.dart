import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

void main() {
  String _userJsonString(User user) {
    return '''{"id": ${user.id}, "name": "${user.name}", "icon": "${user.icon}", "profile": "${user.profile}", "is_follower": ${user.isFollower}, "followee_count": ${user.followeeCount}}''';
  }

  group('User Class Test', () {
    test('Init', () {
      final user = User(
        id: 1,
        name: "鈴木 一郎",
        icon: "https://example.com/icon/1",
        profile: "鈴木 一郎です。",
        isFollower: false,
        followeeCount: 5,
      );

      expect(user.id, 1);
      expect(user.name, "鈴木 一郎");
      expect(user.icon, "https://example.com/icon/1");
      expect(user.profile, "鈴木 一郎です。");
      expect(user.isFollower, false);
      expect(user.followeeCount, 5);
    });

    test('Init fromJson', () {
      final jsonString = _userJsonString(
        User(
          id: 1,
          name: "鈴木 一郎",
          icon: "https://example.com/icon/1",
          profile: "鈴木 一郎です。",
          isFollower: false,
          followeeCount: 5,
        ),
      );
      final json = jsonDecode(jsonString);

      final user = User.fromJson(json);

      expect(user.id, 1);
      expect(user.name, "鈴木 一郎");
      expect(user.icon, "https://example.com/icon/1");
      expect(user.profile, "鈴木 一郎です。");
      expect(user.isFollower, false);
      expect(user.followeeCount, 5);
    });
  });

  group('Users Class Test', () {
    final user1 = User(
      id: 1,
      name: "鈴木 一郎",
      icon: "https://example.com/icon/1",
      profile: "鈴木 一郎です。",
      isFollower: false,
      followeeCount: 5,
    );
    final user2 = User(
      id: 2,
      name: "佐藤 二郎",
      icon: "https://example.com/icon/2",
      profile: "佐藤 二郎です。",
      isFollower: true,
      followeeCount: 10,
    );

    test('Init', () {
      final users = Users(users: [user1, user2], containsFirstUser: true);

      expect(users.users, [user1, user2]);
      expect(users.containsFirstUser, true);
    });

    test('Init fromJson', () {
      final jsonString =
          '''{"users": [${_userJsonString(user1)}, ${_userJsonString(user2)}], "contains_first_user": true}''';
      final json = jsonDecode(jsonString);

      final users = Users.fromJson(json);

      expect(users.users, [user1, user2]);
      expect(users.containsFirstUser, true);
    });

    test('copyWith', () {
      final users = Users(users: [user1, user2], containsFirstUser: true);

      final newUsers = users.copyWith([user1], false);

      expect(newUsers.users, [user1]);
      expect(newUsers.containsFirstUser, false);
      expect(newUsers, isNot(equals(users)));
    });
  });
}
