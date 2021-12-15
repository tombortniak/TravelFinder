import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/pages/date_selection_page.dart';
import 'package:travel_finder/components/flight_search_field.dart';
import 'package:travel_finder/services/database.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/arrival_airport.dart';

class FlightSearchPage extends StatefulWidget {
  final AirportFinder _airportFinder = AirportFinder();

  FlightSearchPage({Key? key}) : super(key: key);

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  List<Airport>? _availableAirports;
  List<bool> _isSelected = [true, false];

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
              color: Colors.white,
              child: Column(
                children: [
                  AppBar(
                    title: Text('Flight search'),
                  ),
                  Container(
                    color: Colors.blue,
                    child: Column(
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
                            );
                          },
                        ),
                        FlightSearchField(
                          text: ArrivalAirportText(),
                          icon: FaIcon(
                            FontAwesomeIcons.planeArrival,
                            color: Colors.grey,
                          ),
                          onTap: () {
                            showMaterialModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (context) => AirportSelectionPage(
                                  airports: _availableAirports,
                                  isArrivalAirport: true),
                            );
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FlightSearchField(
                                text: Text('Departure date'),
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
                            ),
                            Expanded(
                              child: FlightSearchField(
                                text: Text('Return date'),
                                icon: FaIcon(
                                  FontAwesomeIcons.calendar,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  showMaterialModalBottomSheet(
                                    context: context,
                                    builder: (context) => DateSelectionPage(),
                                    backgroundColor: Colors.transparent,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                  child: ToggleButtons(
                                    color: Colors.white,
                                    borderColor: Colors.transparent,
                                    borderRadius: BorderRadius.circular(10.0),
                                    fillColor: Colors.white,
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            children: [
                                              FaIcon(FontAwesomeIcons
                                                  .longArrowAltRight),
                                              Text('One way'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Column(
                                            children: [
                                              FaIcon(
                                                  FontAwesomeIcons.exchangeAlt),
                                              Text('Round trip'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                        ],
                                      ),
                                    ],
                                    isSelected: _isSelected,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int buttonIndex = 0;
                                            buttonIndex < _isSelected.length;
                                            buttonIndex++) {
                                          if (buttonIndex == index) {
                                            _isSelected[buttonIndex] = true;
                                          } else {
                                            _isSelected[buttonIndex] = false;
                                          }
                                        }
                                      });
                                    },
                                  ),
                                  margin: EdgeInsets.only(left: 15.0)),
                            ),
                            Expanded(
                              flex: 2,
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
