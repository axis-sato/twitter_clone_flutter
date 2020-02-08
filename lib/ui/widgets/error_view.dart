import 'package:flutter/material.dart';
import 'package:twitter_clone_flutter/core/utils/failure.dart';

class ErrorView extends StatelessWidget {
  final Failure _failure;
  final VoidCallback _onPressed;

  const ErrorView({@required Failure failure, @required VoidCallback onPressed})
      : _failure = failure,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(_failure.message),
          RaisedButton(
            child: Text('リロード'),
            onPressed: _onPressed,
          )
        ],
      ),
    );
  }
}
