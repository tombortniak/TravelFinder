import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/components/flight_details_field.dart';
import 'package:travel_finder/services/airport_database.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:travel_finder/components/button.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:intl/intl.dart';

class FlightSearchPage extends StatefulWidget {
  FlightSearchPage({Key? key}) : super(key: key);

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  List<Airport>? _availableAirports;

  FlightType getCurrentFlightType() {
    return context.read<FlightDetails>().flightType;
  }

  void resetFlightDetails() {
    context.read<FlightDetails>().resetAll();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Airport>>(
        future: AirportDatabase.getAvailableAirports(),
        builder: (BuildContext context, AsyncSnapshot<List<Airport>> snapshot) {
          Widget child;
          if (snapshot.hasError) {
            child = Column(
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
            _availableAirports = snapshot.data;
            child = Container(
              color: Colors.white,
              child: Column(
                children: [
                  AppBar(
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Flight details',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          Column(
                            children: [
                              FlightDetailsField(
                                text: Text(
                                  context
                                              .watch<FlightDetails>()
                                              .departureAirport ==
                                          null
                                      ? 'Departure airport'
                                      : context
                                          .watch<FlightDetails>()
                                          .departureAirport!
                                          .name,
                                  style: context
                                              .watch<FlightDetails>()
                                              .departureAirport !=
                                          null
                                      ? Theme.of(context).textTheme.bodyText1
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(color: Colors.grey),
                                ),
                                icon: FaIcon(
                                  FontAwesomeIcons.planeDeparture,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  showGeneralDialog(
                                    context: context,
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        AirportSelectionPage(
                                            availableAirports:
                                                _availableAirports,
                                            isArrivalAirport: false),
                                    transitionDuration:
                                        Duration(milliseconds: 100),
                                  );
                                },
                              ),
                              FlightDetailsField(
                                text: Text(
                                  context
                                              .watch<FlightDetails>()
                                              .arrivalAirport ==
                                          null
                                      ? 'Arrival airport'
                                      : context
                                          .watch<FlightDetails>()
                                          .arrivalAirport!
                                          .name,
                                  style: context
                                              .watch<FlightDetails>()
                                              .arrivalAirport !=
                                          null
                                      ? Theme.of(context).textTheme.bodyText1
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(color: Colors.grey),
                                ),
                                icon: FaIcon(
                                  FontAwesomeIcons.planeArrival,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  if (context
                                          .read<FlightDetails>()
                                          .departureAirport ==
                                      null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Departure airport must be set',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(color: Colors.white),
                                        ),
                                        duration: Duration(seconds: 2),
                                        backgroundColor: Colors.red,
                                        padding: EdgeInsets.all(20.0),
                                      ),
                                    );
                                  } else {
                                    showGeneralDialog(
                                      context: context,
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          AirportSelectionPage(
                                              availableAirports:
                                                  _availableAirports,
                                              isArrivalAirport: true),
                                      transitionDuration:
                                          Duration(milliseconds: 100),
                                    );
                                  }
                                },
                              ),
                              FlightDetailsField(
                                text: Text(
                                  context
                                              .watch<FlightDetails>()
                                              .travelDateRange ==
                                          null
                                      ? 'Data range'
                                      : (context
                                                  .watch<FlightDetails>()
                                                  .travelDateRange!
                                                  .start ==
                                              context
                                                  .watch<FlightDetails>()
                                                  .travelDateRange!
                                                  .end
                                          ? '${DateFormat('EEE, MMM d').format(context.watch<FlightDetails>().travelDateRange!.start)}'
                                          : '${DateFormat('EEE, MMM d').format(context.watch<FlightDetails>().travelDateRange!.start)} - ${DateFormat('EEE, MMM d').format(context.watch<FlightDetails>().travelDateRange!.end)}'),
                                  style: context
                                              .watch<FlightDetails>()
                                              .travelDateRange !=
                                          null
                                      ? Theme.of(context).textTheme.bodyText1
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(color: Colors.grey),
                                ),
                                icon: FaIcon(
                                  FontAwesomeIcons.calendar,
                                  color: Colors.grey,
                                ),
                                onTap: () async {
                                  final selectedDateRange =
                                      await showDateRangePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(
                                        DateTime.now().year + 1,
                                        DateTime.now().month,
                                        DateTime.now().day),
                                  );
                                  context
                                      .read<FlightDetails>()
                                      .travelDateRange = selectedDateRange;
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ToggleButtons(
                                    borderRadius: BorderRadius.circular(5.0),
                                    fillColor: Colors.blue,
                                    selectedColor: Colors.white,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'One way',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Round trip',
                                        ),
                                      ),
                                    ],
                                    isSelected: [
                                      getCurrentFlightType() ==
                                          FlightType.oneWay,
                                      getCurrentFlightType() ==
                                          FlightType.roundTrip
                                    ],
                                    onPressed: (int index) {
                                      setState(
                                        () {
                                          index == FlightType.oneWay.index
                                              ? context
                                                      .read<FlightDetails>()
                                                      .flightType =
                                                  FlightType.oneWay
                                              : context
                                                      .read<FlightDetails>()
                                                      .flightType =
                                                  FlightType.roundTrip;
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SleekCircularSlider(
                            appearance: CircularSliderAppearance(
                              size: 180.0,
                              spinnerDuration: 1,
                              animDurationMultiplier: 0.5,
                              customColors: CustomSliderColors(
                                dotColor: Colors.blue,
                                progressBarColor: Colors.blue,
                                trackColor: Colors.grey,
                              ),
                              customWidths: CustomSliderWidths(
                                  progressBarWidth: 4.0, handlerSize: 5.0),
                            ),
                            min: 1,
                            max: 500,
                            initialValue: context.read<FlightDetails>().budget,
                            onChange: (double value) {
                              context.read<FlightDetails>().budget = value;
                            },
                            innerWidget: (double value) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Budget',
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                  ),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  Text(
                                    '${value.round()} €',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ],
                              );
                            },
                          ),
                          Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Button(
                                    text: 'Reset',
                                    backgroundColor: Colors.amber,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      resetFlightDetails();
                                    },
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  child: Button(
                                    text: 'Search',
                                    backgroundColor: Colors.greenAccent,
                                    textColor: Colors.black,
                                    onPressed: () {
                                      var departureAirport = context
                                          .read<FlightDetails>()
                                          .departureAirport;
                                      var arrivalAirport = context
                                          .read<FlightDetails>()
                                          .arrivalAirport;
                                      var dateRange = context
                                          .read<FlightDetails>()
                                          .travelDateRange;
                                      if (departureAirport == null ||
                                          arrivalAirport == null ||
                                          dateRange == null) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Departure airport, arrival airport and data range must be set',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .copyWith(
                                                      color: Colors.white),
                                            ),
                                            duration: Duration(seconds: 2),
                                            backgroundColor: Colors.red,
                                            padding: EdgeInsets.all(20.0),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            child = Container(
              color: Colors.white,
              child: Center(
                child: SpinKitRing(
                  color: Colors.blue,
                  size: 50.0,
                ),
              ),
            );
          }

          return AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: child,
          );
        });
  }
}
