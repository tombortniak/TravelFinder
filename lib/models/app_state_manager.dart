import 'dart:async';
import 'package:flutter/material.dart';

class TravelFinderTab {
  static const int explore = 0;
  static const int settings = 1;
  static const int about = 1;
}

class AppStateManager extends ChangeNotifier {
  int _selectedTab = TravelFinderTab.explore;

  int get selectedTab => _selectedTab;

  // TODO: initialize app function

  void goToTab(index) {
    _selectedTab = index;
    notifyListeners();
  }
}
