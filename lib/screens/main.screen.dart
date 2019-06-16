import 'package:flutter/material.dart';
import 'package:instagrao/widgets/bottom-tabs/bottom-tabs.widget.dart';

import './play.screen.dart';
import './products.screen.dart';
import './matchs.screen.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    ProductsScreen(),
    PlayScreen(),
    MatchsScreen(),
  ];

  void onTapTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
        icon: new Icon(Icons.view_list),
        title: new Text('Products'),
      ),
      BottomNavigationBarItem(
        icon: new Icon(Icons.play_circle_outline),
        title: new Text('GO!'),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.favorite),
        title: Text('Matchs'),
      )
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: _children[_currentIndex],
        bottomNavigationBar: BottomTabs.widget(onTapTapped, _currentIndex, items),
      ),
    );
  }
}
