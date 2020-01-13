import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';
import 'package:intl/intl.dart';

class TweetScreen extends StatelessWidget {
  final Tweet _tweet;

  TweetScreen({Key key, @required tweet})
      : _tweet = tweet,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ツイート'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _Profile(
                user: _tweet.user,
              ),
              SizedBox(height: 10),
              _Tweet(
                tweet: _tweet,
              ),
              SizedBox(height: 5),
              _CreatedAt(
                dateTime: _tweet.createdAt,
              ),
              SizedBox(height: 5),
              Like(
                like: _tweet.like,
                isLiked: _tweet.isLiked,
                fontSize: 15,
                iconSize: 20,
              ),
            ],
          ),
        ));
  }
}

class _Profile extends StatelessWidget {
  final User _user;

  _Profile({@required User user}) : _user = user;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Image.asset(
          _user.icon,
          height: 50,
          width: 50,
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            _user.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _Tweet extends StatelessWidget {
  final Tweet _tweet;

  _Tweet({@required Tweet tweet}) : _tweet = tweet;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        _tweet.tweet,
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}

class _CreatedAt extends StatelessWidget {
  final DateTime _dateTime;

  const _CreatedAt({@required dateTime}) : _dateTime = dateTime;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('yyyy年MM月dd日 HH:mm');
    return Text(
      formatter.format(_dateTime),
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}
