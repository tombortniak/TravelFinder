import 'package:flutter/material.dart';
import 'package:travel_finder/components/option_card.dart';
import 'package:travel_finder/components/option_content.dart';

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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SizedBox()),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OptionCard(
                    optionContent: OptionContent(
                      title: 'Flights',
                      icon: Icons.airplanemode_active,
                    ),
                  ),
                ),
                Expanded(
                  child: OptionCard(
                    optionContent: OptionContent(
                      title: 'Stays',
                      icon: Icons.house,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: OptionCard(
              optionContent: OptionContent(
                title: 'Plan travel',
                icon: Icons.calendar_today,
              ),
            ),
          ),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
