class User {
  final String name;
  final String icon;
  final String profile;
  final bool isFollower;
  final int followerCount;

  const User(
      {this.name,
      this.icon,
      this.profile,
      this.isFollower,
      this.followerCount});
}
