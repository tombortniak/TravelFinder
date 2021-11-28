import 'package:flutter/material.dart';
import 'package:travel_finder/components/option_card.dart';
import 'package:travel_finder/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 30.0),
              child: Center(
                child: Text(
                  'What would you like to do?',
                  textAlign: TextAlign.center,
                  style: kHomePageTitleTextStyle,
                ),
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
                  ),
                ),
                Expanded(
                  child: OptionCard(
                    title: 'Find stays',
                    image: AssetImage('graphics/stays.jpg'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: OptionCard(
              title: 'Plan travel',
              image: AssetImage('graphics/travel_plan.jpg'),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
