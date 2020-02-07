import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone_flutter/core/services/tweet_service.dart';
import 'package:twitter_clone_flutter/core/services/user_service.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/tweet_list/tweet_list_view_model.dart';
import 'package:twitter_clone_flutter/ui/screens/user_list/user_list_screen.dart';
import 'package:twitter_clone_flutter/ui/screens/user_list/user_list_view_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            this._index = index;
          });
        },
        children: <Widget>[
          ChangeNotifierProvider(
            create: (context) => TweetListViewModel(
                tweetService:
                    Provider.of<TweetService>(context, listen: false)),
            child: TweetListScreen(
              key: PageStorageKey<String>('tweet_list'),
            ),
          ),
          ChangeNotifierProvider(
            create: (context) => UserListViewModel(
                userService: Provider.of<UserService>(context, listen: false)),
            child: UserListScreen(
              key: PageStorageKey<String>('user_list'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 10),
            curve: Curves.ease,
          );
        },
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('ホーム'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('ユーザ'),
          )
        ],
      ),
    );
  }
}
