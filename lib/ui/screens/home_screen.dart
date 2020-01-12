import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_screen.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';

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
      child: InkWell(
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
                      child: Like(like: tweet.like, isLiked: tweet.isLiked),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TweetScreen(
              tweet: tweet,
            ),
          ),
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
