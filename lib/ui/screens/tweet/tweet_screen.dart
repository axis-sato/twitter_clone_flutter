import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/tweet_model.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';

class TweetScreen extends StatelessWidget {
  static Widget create(
      BuildContext context, Tweet tweet, TweetModel tweetModel) {
    return ChangeNotifierProvider.value(
      value: tweetModel,
      child: TweetScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ツイート'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TweetModel>(
            builder: (context, vm, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _Profile(
                  user: vm.tweet.user,
                ),
                SizedBox(height: 10),
                _Tweet(
                  tweet: vm.tweet,
                ),
                SizedBox(height: 5),
                _CreatedAt(
                  dateTime: vm.tweet.createdAt,
                ),
                SizedBox(height: 5),
                Like(
                  like: vm.tweet.like,
                  isLiked: vm.tweet.isLiked,
                  fontSize: 15,
                  iconSize: 20,
                  onPressed: (isLike) {
                    final vm = Provider.of<TweetModel>(context, listen: false);
                    if (isLike) {
                      vm.unlike(vm.tweet.id);
                    } else {
                      vm.like(vm.tweet.id);
                    }
                  },
                ),
              ],
            ),
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
        Image.network(
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
