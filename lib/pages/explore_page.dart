import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/components/explore_option_card.dart';
import 'package:travel_finder/constants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(top: 100.0),
          child: const Text(
            'What would you like to do?',
            textAlign: TextAlign.center,
            style: kTitleTextStyle,
          ),
        ),
        const SizedBox(
          height: 100.0,
        ),
        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ExploreOptionCard(
                    title: 'Find flights',
                    icon: FontAwesomeIcons.plane,
                    onTap: () => Navigator.pushNamed(context, '/flightSearch'),
                  ),
                ),
                Expanded(
                  child: ExploreOptionCard(
                    title: 'Find stays',
                    icon: FontAwesomeIcons.home,
                    onTap: () {},
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 5,
                  child: ExploreOptionCard(
                    title: 'Plan trip',
                    icon: FontAwesomeIcons.solidCalendar,
                    onTap: () {},
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: SizedBox(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
