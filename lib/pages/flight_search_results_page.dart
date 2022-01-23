import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/models/flight.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:travel_finder/pages/flight_search_result_details_page.dart';
import 'package:travel_finder/services/web_api/ryanair_flights_api.dart';
import 'package:travel_finder/components/search_result_card.dart';

class FlightSearchResultsPage extends StatefulWidget {
  final FlightDetails _flightDetails;

  FlightSearchResultsPage({required flightDetails})
      : _flightDetails = flightDetails;

  @override
  State<FlightSearchResultsPage> createState() =>
      _FlightSearchResultsPageState();
}

class _FlightSearchResultsPageState extends State<FlightSearchResultsPage> {
  RyanairFlightsApi flightsApi = RyanairFlightsApi();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: flightsApi.fetchCheapestOneWayFlights(widget._flightDetails),
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
          Widget child;
          if (snapshot.data.length > 1) {
            child = Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(snapshot.data[index].arrivalAirport.name),
                      subtitle:
                          Text(snapshot.data[index].arrivalAirport.countryName),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return FlightSearchResultDetailsPage(
                                flight: snapshot.data[index]);
                          },
                        );
                      },
                    );
                  }),
            );
          } else {
            final Flight flight = snapshot.data.first;
            child = Expanded(
              child: Container(
                child: Column(
                  children: [
                    Text(
                      'Cheapest flight',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      child: SearchResultCard(
                        flight: flight,
                      ),
                      margin: EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 40.0),
                    )
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                AppBar(),
                child,
              ],
            ),
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
