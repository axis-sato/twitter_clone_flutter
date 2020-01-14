import 'package:flutter/material.dart';

class UserListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ユーザ'),
      ),
      body: Center(
        child: Text('ユーザ一覧'),
      ),
    );
  }
}
