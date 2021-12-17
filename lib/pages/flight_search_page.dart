import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/pages/date_selection_page.dart';
import 'package:travel_finder/components/flight_search_field.dart';
import 'package:travel_finder/services/database.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/arrival_airport.dart';
import 'package:travel_finder/services/json_converter.dart';
import 'package:travel_finder/services/http_manager.dart';
import 'package:provider/provider.dart';

class FlightSearchPage extends StatefulWidget {
  final AirportFinder _airportFinder = AirportFinder();

  FlightSearchPage({Key? key}) : super(key: key);

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  List<Airport>? _availableAirports;

  Future<List<Airport>> getAvailableAirports() async {
    return widget._airportFinder.getAvailableAirports();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Airport>>(
        future: getAvailableAirports(),
        builder: (BuildContext context, AsyncSnapshot<List<Airport>> snapshot) {
          if (snapshot.hasData) {
            _availableAirports = snapshot.data;
            return Container(
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FlightSearchField(
                          text: DepartureAirportText(),
                          icon: FaIcon(
                            FontAwesomeIcons.planeDeparture,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            showMaterialModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => AirportSelectionPage(
                                  airports: _availableAirports,
                                  isArrivalAirport: false),
                              expand: false,
                            );
                          },
                        ),
                        FlightSearchField(
                          text: ArrivalAirportText(),
                          icon: FaIcon(
                            FontAwesomeIcons.planeArrival,
                            color: Colors.grey,
                          ),
                          onTap: () async {
                            if (context.read<DepartureAirport>().airport.name !=
                                'Departure airport') {
                              var departureAirportIataCode = context
                                  .read<DepartureAirport>()
                                  .airport
                                  .iataCode;

                              HttpManager http = HttpManager(
                                  url:
                                      '$kBaseRyanairUrl$kOneWayUrl&departureAirportIataCode=$departureAirportIataCode&inboundDepartureDateFrom=2021-12-20&inboundDepartureDateTo=2022-12-20&market=en-gb&outboundDepartureDateFrom=2021-12-20&outboundDepartureDateTo=2022-12-20&priceValueTo=1000');

                              var data = await http.getData();
                              JsonConverter converter = JsonConverter();
                              var airports = converter.convertToAirports(data);

                              showMaterialModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => AirportSelectionPage(
                                      airports: airports,
                                      isArrivalAirport: true),
                                  expand: false);
                            }
                          },
                        ),
                        FlightSearchField(
                          text: Text('Dates'),
                          icon: FaIcon(
                            FontAwesomeIcons.calendar,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            showMaterialModalBottomSheet(
                              context: context,
                              builder: (context) => DateSelectionPage(),
                              backgroundColor: Colors.transparent,
                              expand: false,
                            );
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: ElevatedButton(
                                  child: Text('Clear'),
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.amber,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(15.0)),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: ElevatedButton(
                                  child: Text('Search'),
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.greenAccent,
                                      onPrimary: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                      ),
                                      padding: EdgeInsets.all(15.0)),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 5.0),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: SpinKitRotatingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            );
          }
        });
  }
}
