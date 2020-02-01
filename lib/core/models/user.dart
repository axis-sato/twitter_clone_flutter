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
