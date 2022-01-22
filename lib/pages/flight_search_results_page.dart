import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/models/flight.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_finder/services/web_api/ryanair_flights_api.dart';

class FlightSearchResultsPage extends StatefulWidget {
  final FlightDetails _flightDetails;

  FlightSearchResultsPage({required flightDetails})
      : _flightDetails = flightDetails;

  @override
  State<FlightSearchResultsPage> createState() =>
      _FlightSearchResultsPageState();
}

class _FlightSearchResultsPageState extends State<FlightSearchResultsPage> {
  RyanairFlightsApi ryanairFlightsApi = RyanairFlightsApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ryanairFlightsApi.fetchOneWayFlights(widget._flightDetails),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Something went wrong',
                style: Theme.of(context).textTheme.headline2,
              ),
              Text(
                'Error while downloading data from database',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              )
            ],
          );
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return ListTile(
                subtitle: Text(snapshot.data[index].departureAirport.name),
                title: Text(snapshot.data[index].arrivalAirport.name),
                trailing:
                    Text('${snapshot.data[index].ticketPrice.toString()} EUR'),
              );
            },
          );
        } else {
          return Container(
            color: Colors.white,
            child: Center(
              child: SpinKitRing(
                color: Colors.blue,
                size: 50.0,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
