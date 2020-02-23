import 'package:flutter/material.dart';

class Like extends StatelessWidget {
  final int _like;
  final bool _isLiked;
  final double _fontSize;
  final double _iconSize;
  final Function(bool) _onPressed;

  IconData get _icon => _isLiked ? Icons.favorite : Icons.favorite_border;
  Color get _iconColor => _isLiked ? Colors.pink : Colors.grey;

  Like({
    Key key,
    @required int like,
    @required bool isLiked,
    @required Function(bool) onPressed,
    double fontSize = 12,
    double iconSize = 15,
  })  : _like = like,
        _isLiked = isLiked,
        _onPressed = onPressed,
        _fontSize = fontSize,
        _iconSize = iconSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          height: _iconSize,
          width: _iconSize,
          child: IconButton(
            icon: Icon(
              _icon,
              color: _iconColor,
            ),
            padding: EdgeInsets.all(0),
            iconSize: _iconSize,
            onPressed: () => _onPressed(_isLiked),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          _like.toString(),
          style: TextStyle(
            fontSize: _fontSize,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
