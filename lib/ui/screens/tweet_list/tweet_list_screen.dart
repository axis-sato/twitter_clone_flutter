import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/ui/screens/post_tweet/tweet_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_view_model.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_screen.dart';
import 'package:twitter_clone_flutter/ui/widgets/bottom_loader.dart';
import 'package:twitter_clone_flutter/ui/widgets/error_view.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';
import 'package:twitter_clone_flutter/ui/widgets/loading.dart';

class TweetListScreen extends StatefulWidget {
  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TweetListViewModel(
          tweetService: Provider.of<TweetService>(context, listen: false)),
      child: TweetListScreen(
        key: PageStorageKey<String>('tweet_list'),
      ),
    );
  }

  TweetListScreen({Key key}) : super(key: key);

  @override
  _TweetListScreenState createState() => _TweetListScreenState();
}

class _TweetListScreenState extends State<TweetListScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 100.0;

  @override
  void initState() {
    super.initState();
    Provider.of<TweetListViewModel>(context, listen: false).init();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  _showErrorMessage(String message) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ホーム'),
      ),
      body: Consumer<TweetListViewModel>(
        builder: (context, vm, child) {
          if (vm.loading) {
            return Loading();
          }

          return vm.failure != null && vm.tweets.isEmpty
              ? ErrorView(
                  failure: vm.failure,
                  onPressed: () => vm.init(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await vm.getNewTweets();
                    return null;
                  },
                  child: ListView.builder(
                    itemBuilder: (context, int index) {
                      if (index == vm.tweets.length) {
                        return vm.bottomLoading ? BottomLoader() : Container();
                      }
                      final tweet = vm.tweets[index];
                      return _Tweet(tweet: tweet);
                    },
                    itemCount: vm.tweets.length + 1,
                    controller: _scrollController,
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostTweetScreen.create(context),
            fullscreenDialog: true,
          ),
        ),
        tooltip: 'ツイート',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      final vm = Provider.of<TweetListViewModel>(context, listen: false);
      vm.getMoreTweets();
    }
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
