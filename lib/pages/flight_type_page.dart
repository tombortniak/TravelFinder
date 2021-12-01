import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/components/flight_type_card.dart';
import 'package:travel_finder/pages/flight_details_page.dart';
import 'package:travel_finder/services/airports.dart';

class FlightTypePage extends StatelessWidget {
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                title: Text('Flight type'),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlightTypeCard(
                      title: 'One way',
                      onTap: () {
                        Navigator.pushNamed(
                            context, FlightDetailsPage.routeName,
                            arguments: FlightType.oneWay);
                      },
                    ),
                    FlightTypeCard(
                      title: 'Return',
                      onTap: () {
                        Navigator.pushNamed(
                            context, FlightDetailsPage.routeName,
                            arguments: FlightType.roundTrip);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
