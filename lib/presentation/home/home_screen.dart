import 'package:flutter/material.dart';
import 'package:movieguide/shared/constant.dart';

import 'views/views.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    TabPopular(),
    TabRated(),
    TabNewest(),
    TabFavorite(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: IndexedStack(
          children: tabs,
          index: _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (idx) {
            if (_currentIndex == idx) return;
            setState(() {
              _currentIndex = idx;
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text(TAB_POPULAR),
              icon: Icon(Icons.home),
              backgroundColor: Colors.redAccent,
            ),
            BottomNavigationBarItem(
              title: Text(TAB_RATED),
              icon: Icon(Icons.thumb_up),
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              title: Text(TAB_NEWEST),
              icon: Icon(Icons.fiber_new),
              backgroundColor: Colors.orangeAccent,
            ),
            BottomNavigationBarItem(
              title: Text(TAB_FAVORITE),
              icon: Icon(Icons.favorite),
              backgroundColor: Colors.purpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
