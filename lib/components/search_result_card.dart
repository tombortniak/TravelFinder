import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/models/flight.dart';
import 'package:intl/intl.dart';

class SearchResultCard extends StatelessWidget {
  final Flight _flight;
  SearchResultCard({required flight}) : _flight = flight;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                FontAwesomeIcons.plane,
                size: 40.0,
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text(
                        _flight.departureAirport.iataCode,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        DateFormat.Hm().format(_flight.departureDateTime),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Icon(FontAwesomeIcons.arrowRight),
                  SizedBox(
                    width: 10.0,
                  ),
                  Column(
                    children: [
                      Text(
                        _flight.arrivalAirport.iataCode,
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        DateFormat.Hm().format(_flight.arrivalDateTime),
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'DATE',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${DateFormat.yMMMd().format(_flight.departureDateTime)}',
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
              Column(
                children: [
                  Text(
                    'PRICE',
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${_flight.ticketPrice} EUR',
                    style: Theme.of(context).textTheme.headline3,
                  )
                ],
              ),
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.purple),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(10.0),
    );
  }
}
