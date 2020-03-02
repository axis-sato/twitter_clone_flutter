import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/models/tweet.dart';
import 'package:twitter_clone_flutter/core/utils/app_constants.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet/tweet_screen_arguments.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_view_model.dart';
import 'package:twitter_clone_flutter/ui/viewmodels/tweet_model.dart';
import 'package:twitter_clone_flutter/ui/widgets/loader.dart';
import 'package:twitter_clone_flutter/ui/widgets/error_view.dart';
import 'package:twitter_clone_flutter/ui/widgets/like.dart';

class TweetListScreen extends StatefulWidget {
  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          TweetListViewModel(tweetService: Provider.of(context, listen: false)),
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
    _scrollController.addListener(_onScroll);
    Provider.of<TweetListViewModel>(context, listen: false).init();
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
            return Loader();
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
                        return vm.bottomLoading ? Loader() : Container();
                      }
                      final tweet = vm.tweets[index];
                      return _Tweet.create(context, tweet);
                    },
                    itemCount: vm.tweets.length + 1,
                    controller: _scrollController,
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final tweet = await Navigator.pushNamed(
            context,
            RoutePaths.PostTweet,
          );

          if (tweet is Tweet) {
            Provider.of<TweetListViewModel>(context, listen: false)
                .unshiftTweet(tweet);
          }
        },
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
  static Widget create(BuildContext context, Tweet tweet) {
    return ChangeNotifierProvider(
      create: (context) => TweetModel(
        tweetService: Provider.of(context, listen: false),
        tweet: tweet,
      ),
      child: _Tweet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TweetModel>(
      builder: (context, vm, child) => Card(
        child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    vm.tweet.user.icon,
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
                            Text(vm.tweet.user.name),
                            SizedBox(width: 5),
                            Text(
                              _duration(from: vm.tweet.createdAt),
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        Text(vm.tweet.tweet),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Like(
                            like: vm.tweet.like,
                            isLiked: vm.tweet.isLiked,
                            onPressed: (isLike) {
                              if (isLike) {
                                vm.unlike(vm.tweet.id);
                              } else {
                                vm.like(vm.tweet.id);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(
                context,
                RoutePaths.Tweet,
                arguments: TweetScreenArguments(
                  vm.tweet,
                  Provider.of(context, listen: false),
                ),
              );
            }),
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
