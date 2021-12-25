import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/models/date_range.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/pages/date_selection_page.dart';
import 'package:travel_finder/components/flight_search_field.dart';
import 'package:travel_finder/services/airport_database.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/arrival_airport.dart';
import 'package:provider/provider.dart';
import 'package:travel_finder/models/available_destinations.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:travel_finder/components/button.dart';

class FlightSearchPage extends StatefulWidget {
  FlightSearchPage({Key? key}) : super(key: key);

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  List<Airport>? _availableAirports;
  List<bool> _isSelected = [true, false];
  double _currentBudgetSliderValue = 150.0;

  void resetDepartureAirportField() {
    context.read<DepartureAirport>().resetAirport();
  }

  void resetArrivalAirportField() {
    context.read<ArrivalAirport>().resetAirport();
  }

  void resetDateRangeField() {
    context.read<DateRange>().resetDateRange();
  }

  void resetFlightTypeToggleButton() {
    setState(() {
      _isSelected[FlightType.oneWay.index] = true;
      _isSelected[FlightType.roundTrip.index] = false;
    });
  }

  void resetBudgetSlider() {
    setState(() {
      _currentBudgetSliderValue = 150.0;
    });
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
                                      availableAirports: _availableAirports,
                                      isArrivalAirport: false,
                                    ),
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
                                  if (context
                                          .read<DepartureAirport>()
                                          .airport ==
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
                                    showMaterialModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (context) =>
                                          AirportSelectionPage(
                                              availableAirports: context
                                                  .read<AvailableDestinations>()
                                                  .availableDestinations,
                                              isArrivalAirport: true),
                                    );
                                  }
                                },
                              ),
                              FlightSearchField(
                                text: DateRangeText(),
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
                                    isSelected: _isSelected,
                                    onPressed: (int index) {
                                      setState(
                                        () {
                                          for (int buttonIndex = 0;
                                              buttonIndex < _isSelected.length;
                                              buttonIndex++) {
                                            if (buttonIndex == index) {
                                              _isSelected[buttonIndex] = true;
                                            } else {
                                              _isSelected[buttonIndex] = false;
                                            }
                                          }
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
                            initialValue: _currentBudgetSliderValue,
                            onChange: (double value) {
                              _currentBudgetSliderValue = value;
                            },
                            innerWidget: (double value) {
                              _currentBudgetSliderValue = value;
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
                                    '${_currentBudgetSliderValue.round()} €',
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
                                      resetDepartureAirportField();
                                      resetArrivalAirportField();
                                      resetDateRangeField();
                                      resetFlightTypeToggleButton();
                                      resetBudgetSlider();
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
                                          .read<DepartureAirport>()
                                          .airport;
                                      var arrivalAirport = context
                                          .read<ArrivalAirport>()
                                          .airport;
                                      var dateRange =
                                          context.read<DateRange>().dateRange;
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
