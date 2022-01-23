import 'package:flutter/material.dart';
import 'package:travel_finder/components/search_result_card.dart';
import 'package:travel_finder/models/flight.dart';

class FlightSearchResultDetailsPage extends StatelessWidget {
  final Flight _flight;

  FlightSearchResultDetailsPage({required flight}) : _flight = flight;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              child: SearchResultCard(flight: _flight),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            ),
          ],
        ),
      ),
    );
  }
}
