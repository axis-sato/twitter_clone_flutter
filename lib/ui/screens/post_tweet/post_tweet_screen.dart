import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/ui/screens/post_tweet/post_tweet_view_model.dart';

class PostTweetScreen extends StatefulWidget {
  static Widget create(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostTweetViewModel(
        tweetService: Provider.of<TweetService>(context, listen: false),
      ),
      child: PostTweetScreen(),
    );
  }

  @override
  _PostTweetScreenState createState() => _PostTweetScreenState();
}

class _PostTweetScreenState extends State<PostTweetScreen> {
  final _textEditingController = TextEditingController();
  bool _tweetable = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ツイート'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: _TweetButton(
              isActive: _tweetable,
              onPressed: () async {
                final tweet = await Provider.of<PostTweetViewModel>(context,
                        listen: false)
                    .postTweet(_textEditingController.text);
                Navigator.pop(context, tweet);
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 20,
        ),
        child: TextField(
          controller: _textEditingController,
          onChanged: (text) {
            setState(() {
              _tweetable = _textEditingController.text.isNotEmpty;
            });
          },
          autofocus: true,
          style: TextStyle(
            fontSize: 20,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'いまどうしてる？',
          ),
          maxLength: 140,
          maxLines: null,
        ),
      ),
    );
  }
}

class _TweetButton extends StatelessWidget {
  final VoidCallback _onPressed;
  final bool _isActive;
  const _TweetButton(
      {Key key, @required bool isActive, @required VoidCallback onPressed})
      : _isActive = isActive,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('ツイートする'),
      shape: StadiumBorder(),
      onPressed: _isActive ? _onPressed : null,
      color: Colors.lightBlue,
      textColor: Colors.white,
    );
  }
}
