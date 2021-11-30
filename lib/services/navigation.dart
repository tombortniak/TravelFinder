import 'package:flutter/material.dart';
import 'package:travel_finder/pages/explore_page.dart';
import 'package:travel_finder/pages/flights_type_page.dart';

class ExploreNavigator extends StatefulWidget {
  const ExploreNavigator({Key? key}) : super(key: key);

  @override
  _ExploreNavigatorState createState() => _ExploreNavigatorState();
}

class _ExploreNavigatorState extends State<ExploreNavigator> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              switch (settings.name) {
                case '/':
                  return ExplorePage();
                case '/flightsType':
                  return FlightsTypePage();
                default:
                  return Container();
              }
            });
      },
    );
  }
}