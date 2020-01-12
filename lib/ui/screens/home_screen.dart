import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

class HomeScreen extends StatelessWidget {
  final tweets = [
    Tweet(
      tweet:
          "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
      createdAt: DateTime.parse("2020-01-01 20:18:04"),
      user: User(name: "foo", icon: "assets/images/user1.png"),
      like: 0,
      isLiked: false,
    ),
    Tweet(
      tweet: "bbbbb",
      createdAt: DateTime.parse("2020-01-10 22:48:04"),
      user: User(name: "bar", icon: "assets/images/user2.png"),
      like: 10,
      isLiked: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      body: ListView.builder(
        itemBuilder: (context, int index) {
          final tweet = tweets[index];
          return _Tweet(tweet: tweet);
        },
        itemCount: tweets.length,
      ),
    );
  }
}

class _Tweet extends StatelessWidget {
  final Tweet tweet;

  _Tweet({Key key, @required this.tweet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              tweet.user.icon,
              height: 50,
              width: 50,
            ),
            SizedBox(width: 10),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(tweet.user.name),
                      SizedBox(width: 5),
                      Text(
                        _duration(from: tweet.createdAt),
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  Text(tweet.tweet),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: _Like(like: tweet.like, isLiked: tweet.isLiked),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  String _duration({@required DateTime from}) {
    final duration = DateTime.now().difference(from);
    if (duration.inDays > 0) {
      return '${duration.inDays}日';
    }
    if (duration.inHours > 0) {
      return '${duration.inHours}時間';
    }
    if (duration.inMinutes > 0) {
      return '${duration.inMinutes}分';
    }
    return '${duration.inSeconds}秒';
  }
}

class _Like extends StatelessWidget {
  final int like;
  final bool isLiked;

  IconData get icon => isLiked ? Icons.favorite : Icons.favorite_border;
  Color get iconColor => isLiked ? Colors.pink : Colors.grey;

  _Like({@required this.like, @required this.isLiked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 15,
          color: iconColor,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          like.toString(),
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
