import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/models/date_range.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/pages/date_selection_page.dart';
import 'package:travel_finder/components/flight_search_field.dart';
import 'package:travel_finder/services/database.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/arrival_airport.dart';
import 'package:provider/provider.dart';
import 'package:travel_finder/models/available_destinations.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:travel_finder/components/button.dart';
import 'package:get/get.dart';

class FlightSearchPage extends StatefulWidget {
  final AirportFinder _airportFinder = AirportFinder();

  FlightSearchPage({Key? key}) : super(key: key);

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  List<Airport>? _availableAirports;
  List<bool> isSelected = [true, false];
  double _currentSliderValue = 100;
  bool oneWay = true;

  Future<List<Airport>> getAvailableAirports() async {
    return widget._airportFinder.getAvailableAirports();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Airport>>(
        future: getAvailableAirports(),
        builder: (BuildContext context, AsyncSnapshot<List<Airport>> snapshot) {
          Widget child;
          if (snapshot.hasData) {
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: Text(
                            'Flight details',
                            style: TextStyle(fontSize: 25.0),
                          ),
                          margin: EdgeInsets.only(bottom: 25.0),
                        ),
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
                          onTap: () {
                            if (context.read<DepartureAirport>().airport ==
                                null) {
                              Get.snackbar(
                                  'Error', 'Departure airport must be set',
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM,
                                  snackStyle: SnackStyle.FLOATING,
                                  isDismissible: true,
                                  animationDuration:
                                      Duration(milliseconds: 700));
                            } else {
                              showMaterialModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => AirportSelectionPage(
                                      airports: context
                                          .read<AvailableDestinations>()
                                          .availableDestinations,
                                      isArrivalAirport: true),
                                  expand: false);
                            }
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: FlightSearchField(
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
                                    expand: false,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: SleekCircularSlider(
                                  appearance: CircularSliderAppearance(
                                    customColors: CustomSliderColors(
                                      dotColor: Colors.blue,
                                      progressBarColor: Colors.blue,
                                      trackColor: Colors.grey,
                                    ),
                                    customWidths: CustomSliderWidths(
                                        progressBarWidth: 10.0,
                                        handlerSize: 10.0),
                                  ),
                                  min: 1,
                                  max: 500,
                                  initialValue: 150,
                                  onChange: (double value) {
                                    _currentSliderValue = value;
                                  },
                                  innerWidget: (double value) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text('Budget'),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Text('${value.round()} €'),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 15.0, vertical: 10.0),
                                child: Center(
                                  child: ToggleButtons(
                                    borderRadius: BorderRadius.circular(10.0),
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('One way'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Round trip'),
                                      ),
                                    ],
                                    isSelected: isSelected,
                                    onPressed: (int index) {
                                      setState(() {
                                        for (int buttonIndex = 0;
                                            buttonIndex < isSelected.length;
                                            buttonIndex++) {
                                          if (buttonIndex == index) {
                                            isSelected[buttonIndex] = true;
                                          } else {
                                            isSelected[buttonIndex] = false;
                                          }
                                        }
                                        oneWay = isSelected.first;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Button(
                                  text: 'Clear',
                                  backgroundColor: Colors.amber,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    context
                                        .read<DepartureAirport>()
                                        .clearAirport();
                                    context
                                        .read<ArrivalAirport>()
                                        .clearAirport();
                                    context.read<DateRange>().clearDateRange();
                                  },
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                child: Button(
                                  text: 'Search',
                                  backgroundColor: Colors.greenAccent,
                                  textColor: Colors.black,
                                  onPressed: () {
                                    var departureAirport = context
                                        .read<DepartureAirport>()
                                        .airport;
                                    var arrivalAirport =
                                        context.read<ArrivalAirport>().airport;
                                    var dateRange =
                                        context.read<DateRange>().dateRange;
                                    if (departureAirport == null ||
                                        arrivalAirport == null ||
                                        dateRange == null) {
                                      Get.snackbar('Error',
                                          'Departure airport, arrival airport and data range must be set',
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                          snackPosition: SnackPosition.BOTTOM,
                                          snackStyle: SnackStyle.FLOATING,
                                          isDismissible: true,
                                          animationDuration:
                                              Duration(milliseconds: 700));
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
                ],
              ),
            );
          } else {
            child = Container(
              color: Colors.white,
              child: Center(
                child: SpinKitFadingCircle(
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
