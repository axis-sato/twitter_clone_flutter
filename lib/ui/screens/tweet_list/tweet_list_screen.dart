import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';
import 'package:twitter_clone_flutter/core/repositories/tweet_repository.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_view_model.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';

class TweetListScreen extends StatelessWidget {
  TweetListScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      body: ChangeNotifierProvider(
        create: (context) => TweetListViewModel(
            tweetRepository:
                Provider.of<TweetRepository>(context, listen: false))
          ..init(),
        child: Consumer<TweetListViewModel>(
          builder: (context, vm, child) {
            return ListView.builder(
              itemBuilder: (context, int index) {
                final tweet = vm.tweets[index];
                return _Tweet(tweet: tweet);
              },
              itemCount: vm.tweets.length,
            );
          },
        ),
      ),
    );
  }
}

class _Tweet extends StatelessWidget {
  final Tweet _tweet;

  _Tweet({Key key, @required tweet})
      : _tweet = tweet,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Image.network(
                _tweet.user.icon,
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
                        Text(_tweet.user.name),
                        SizedBox(width: 5),
                        Text(
                          _duration(from: _tweet.createdAt),
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Text(_tweet.tweet),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Like(like: _tweet.like, isLiked: _tweet.isLiked),
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
              tweet: _tweet,
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
