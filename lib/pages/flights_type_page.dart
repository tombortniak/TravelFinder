import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';

class FlightsTypePage extends StatelessWidget {
  const FlightsTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'Flights',
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('graphics/flights.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppBar(),
            Container(
              child: Text(
                'Choose flight type',
                textAlign: TextAlign.center,
                style: kTitleTextStyle,
              ),
              margin: EdgeInsets.symmetric(vertical: 70.0, horizontal: 30.0),
            ),
            Container(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'One way',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              margin: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            ),
            Container(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Return',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              margin: EdgeInsets.symmetric(horizontal: 100.0, vertical: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}
