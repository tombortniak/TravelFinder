import 'package:flutter/material.dart';
import 'package:travel_finder/components/option_card.dart';
import 'package:travel_finder/constants.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({Key? key}) : super(key: key);

  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 70.0),
              child: Text(
                'What would you like to do?',
                textAlign: TextAlign.center,
                style: kTitleTextStyle,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: OptionCard(
                    title: 'Find flights',
                    image: AssetImage('graphics/flights.jpg'),
                    onTap: () => Navigator.pushNamed(context, '/flightsType'),
                  ),
                ),
                Expanded(
                  child: OptionCard(
                    title: 'Find stays',
                    image: AssetImage('graphics/stays.jpg'),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: OptionCard(
              title: 'Plan travel',
              image: AssetImage('graphics/travel_plan.jpg'),
              onTap: () {},
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
