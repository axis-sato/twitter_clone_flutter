import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

class UserListScreen extends StatelessWidget {
  UserListScreen({Key key}) : super(key: key);

  final _users = List<User>.generate(100, (int i) {
    return User(
      name: "ユーザ${i + 1}",
      icon: "assets/images/user${(i % 2) + 1}.png",
      profile: "ユーザ${i + 1}です。",
      isFollower: i % 2 == 1,
      followerCount: i,
    );
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザ'),
      ),
      body: ListView.separated(
        separatorBuilder: (context, int i) => Divider(
          color: Colors.black,
        ),
        itemBuilder: (context, int i) {
          return _User(
            user: _users[i],
          );
        },
        itemCount: _users.length,
      ),
    );
  }
}

class _User extends StatelessWidget {
  final User _user;

  _User({Key key, @required User user})
      : _user = user,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            _user.icon,
            height: 50,
            width: 50,
          ),
          SizedBox(width: 10),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _user.name,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _FollowButton(
                      isFollowing: _user.isFollower,
                    ),
                  ],
                ),
                Text(_user.profile),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "フォロワー ${_user.followerCount}人",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final bool _isFollowing;

  _FollowButton({Key key, @required bool isFollowing})
      : _isFollowing = isFollowing,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 25,
      child: FlatButton(
        child: Text(
          _isFollowing ? 'フォロー中' : 'フォローする',
          style: TextStyle(
            color: _isFollowing ? Colors.white : Colors.lightBlue,
            fontSize: 13,
          ),
        ),
        color: _isFollowing ? Colors.lightBlue : Colors.white,
        shape: StadiumBorder(
          side: BorderSide(color: Colors.lightBlue),
        ),
        onPressed: () {},
      ),
    );
  }
}
