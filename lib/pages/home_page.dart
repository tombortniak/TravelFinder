import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'explore_page.dart';
import 'package:travel_finder/services/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBarItemIndex = 0;

  List<GlobalKey<NavigatorState>> _navigatorKeys = [
    exploreNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() {
    if (_navigatorKeys[_selectedBarItemIndex].currentState!.canPop()) {
      _navigatorKeys[_selectedBarItemIndex]
          .currentState!
          .pop(_navigatorKeys[_selectedBarItemIndex].currentContext);
      return Future.value(false);
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return Future.value(true);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedBarItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _selectedBarItemIndex,
            children: [ExploreNavigator()],
          ),
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
