import 'package:flutter/material.dart';

class Like extends StatelessWidget {
  final int _like;
  final bool _isLiked;
  final double _fontSize;
  final double _iconSize;

  IconData get _icon => _isLiked ? Icons.favorite : Icons.favorite_border;
  Color get _iconColor => _isLiked ? Colors.pink : Colors.grey;

  Like({
    Key key,
    @required int like,
    @required bool isLiked,
    double fontSize = 12,
    double iconSize = 15,
  })  : _like = like,
        _isLiked = isLiked,
        _fontSize = fontSize,
        _iconSize = iconSize,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          _icon,
          size: _iconSize,
          color: _iconColor,
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
