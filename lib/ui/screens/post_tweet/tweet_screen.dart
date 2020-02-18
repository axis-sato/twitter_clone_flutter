import 'package:flutter/material.dart';

class PostTweetScreen extends StatefulWidget {
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
    return Center(
      child: Scaffold(
        appBar: AppBar(
          title: Text('ツイート'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: _TweetButton(
                isActive: _tweetable,
                onPressed: () => print(_textEditingController.text),
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
