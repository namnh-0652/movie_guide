import 'package:flutter/material.dart';
import 'package:movieguide/shared/constant.dart';

import 'views/views.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
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
              label: TAB_POPULAR,
              icon: Icon(Icons.home),
              backgroundColor: Colors.redAccent,
            ),
            BottomNavigationBarItem(
              label: TAB_RATED,
              icon: Icon(Icons.thumb_up),
              backgroundColor: Colors.blueAccent,
            ),
            BottomNavigationBarItem(
              label: TAB_NEWEST,
              icon: Icon(Icons.fiber_new),
              backgroundColor: Colors.orangeAccent,
            ),
            BottomNavigationBarItem(
              label: TAB_FAVORITE,
              icon: Icon(Icons.favorite),
              backgroundColor: Colors.purpleAccent,
            ),
          ],
        ),
      ),
    );
  }
}
