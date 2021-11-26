import 'package:flutter/material.dart';
import 'package:travel_finder/components/option_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBarItemIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedBarItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OptionCard(title: 'Flights'),
                OptionCard(title: 'Stays'),
              ],
            ),
            OptionCard(title: 'Plan travel')
          ],
        ),
      ),
    );
  }
}
