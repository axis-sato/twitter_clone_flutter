import 'package:flutter_test/flutter_test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:twitter_clone_flutter/core/infra/api.dart';
import 'package:twitter_clone_flutter/core/models/user.dart';

void main() {
  final _server = MockWebServer(port: 8081);

  setUp(() async {
    await _server.start();
  });

  tearDown(() {
    _server.shutdown();
  });

  test('fetchUsers', () async {
    _server.enqueue(body: '''
    {
  "users": [
    {
      "id": 20,
      "name": "本間 竜佑",
      "icon": "https://avatars2.githubusercontent.com/u/1905224?s=460&v=4",
      "profile": "こんにちは。本間 竜佑と申します。\\nよろしくお願いします。",
      "is_follower": false,
      "followee_count": 0
    },
    {
      "id": 19,
      "name": "新田 裕夏",
      "icon": "https://avatars2.githubusercontent.com/u/1905224?s=460&v=4",
      "profile": "こんにちは。新田 裕夏と申します。\\nよろしくお願いします。",
      "is_follower": false,
      "followee_count": 3
    },
    {
      "id": 18,
      "name": "小柳 奏夢",
      "icon": "https://avatars2.githubusercontent.com/u/1905224?s=460&v=4",
      "profile": "こんにちは。小柳 奏夢と申します。\\nよろしくお願いします。",
      "is_follower": true,
      "followee_count": 3
    }
  ],
  "contains_first_user": false
}
    ''');

    final api = Api(endpoint: 'http://127.0.0.1:8081');
    final users = await api.fetchUsers(100, 1, 100);

    expect(users.containsFirstUser, false);
    expect(users.users, [User(id: 20), User(id: 19), User(id: 18)]);

    final request = _server.takeRequest();
    expect(request.method, 'GET');
    expect(request.uri.path, '/users');
    expect(request.uri.queryParameters,
        {'max_id': '100', 'min_id': '1', 'limit': '100'});
  });
}
