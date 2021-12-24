import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/components/explore_option_card.dart';
import 'package:travel_finder/constants.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'What would you like to do?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline1,
            ),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10.0,
              runSpacing: 10.0,
              children: [
                ExploreOptionCard(
                  title: 'Find flights',
                  icon: FontAwesomeIcons.plane,
                  onTap: () => Navigator.pushNamed(context, '/flightSearch'),
                ),
                ExploreOptionCard(
                  title: 'Find stays',
                  icon: FontAwesomeIcons.home,
                  onTap: () {},
                ),
                ExploreOptionCard(
                  title: 'Plan trip',
                  icon: FontAwesomeIcons.solidCalendar,
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
