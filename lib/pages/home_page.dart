import 'package:flutter/material.dart';
import 'package:travel_finder/services/navigation.dart';
import 'explore_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBarItemIndex = 0;
  final _pages = [ExplorePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedBarItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _selectedBarItemIndex,
          children: [ExploreNavigator()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedBarItemIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
            BottomNavigationBarItem(
                icon: Icon(Icons.info_outline_rounded), label: 'About'),
          ],
        ),
      ),
    );
  }
}
