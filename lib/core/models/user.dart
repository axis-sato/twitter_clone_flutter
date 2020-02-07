class Users {
  final List<User> users;
  final bool containsFirstUser;

  const Users({this.users, this.containsFirstUser});

  static Users fromJson(dynamic json) {
    final users = (json['users'] as List<dynamic>)
        .map((user) => User.fromJson(user))
        .toList();
    return Users(
      users: users,
      containsFirstUser: json['contains_first_user'],
    );
  }

  Users copyWith(List<User> users, bool containsFirstUser) {
    return Users(
      users: users ?? this.users,
      containsFirstUser: containsFirstUser ?? this.containsFirstUser,
    );
  }
}

class User {
  final int id;
  final String name;
  final String icon;
  final String profile;
  final bool isFollower;
  final int followerCount;

  const User({
    this.id,
    this.name,
    this.icon,
    this.profile,
    this.isFollower,
    this.followerCount,
  });

  static User fromJson(dynamic json) {
    return User(
      id: json['id'],
      name: json['name'],
      icon: json['icon'],
      profile: json['profile'],
      isFollower: json['is_follower'],
      followerCount: json['follower_count'],
    );
  }
}
