import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_finder/navigation.dart';
import 'package:provider/provider.dart';
import '../models/models.dart';
import 'explore_page.dart';

class Home extends StatefulWidget {
  final int currentTab;

  static MaterialPage page(int currentTab) {
    return MaterialPage(
      name: TravelFinderPages.home,
      key: ValueKey(TravelFinderPages.home),
      child: Home(
        currentTab: currentTab,
      ),
    );
  }

  const Home({Key? key, required this.currentTab}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static final pages = <Widget>[
    ExplorePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: widget.currentTab,
        children: [
          ExploreNavigator(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.currentTab,
        onTap: (index) {
          Provider.of<AppStateManager>(context, listen: false).goToTab(index);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(
              icon: Icon(Icons.info_outline_rounded), label: 'About'),
        ],
      ),
    );
  }
}
