import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_finder/models/available_destinations.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:travel_finder/services/ryanair_data_fetcher.dart';

class AirportSelectionPage extends StatefulWidget {
  final bool _isArrivalAirport;
  final List<Airport> _availableAirports;
  final Map<String, String> _alpha2CodesByCountries = {};

  AirportSelectionPage({required availableAirports, required isArrivalAirport})
      : _availableAirports = availableAirports,
        _isArrivalAirport = isArrivalAirport {
    groupCountriesWithAlpha2Codes();
  }

  void groupCountriesWithAlpha2Codes() {
    for (var airport in _availableAirports) {
      if (!_alpha2CodesByCountries.containsKey(airport.country)) {
        _alpha2CodesByCountries[airport.country] = airport.countryAlpha2Code;
      }
    }
  }

  @override
  State<AirportSelectionPage> createState() => _AirportSelectionPageState();
}

class _AirportSelectionPageState extends State<AirportSelectionPage> {
  final TextEditingController _editingController = TextEditingController();
  List<Airport> _availableAirports = [];

  String getAlpha2CodeFromCountryName(String countryName) {
    return widget._alpha2CodesByCountries[countryName] ?? '';
  }

  void filterAirportSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Airport> airportSearchResults = [];

      for (var airport in widget._availableAirports) {
        if (airport.name.toLowerCase().contains(query)) {
          airportSearchResults.add(airport);
        }
      }
      setState(() {
        _availableAirports.clear();
        _availableAirports.addAll(airportSearchResults);
      });
    } else {
      setState(() {
        _availableAirports.clear();
        _availableAirports.addAll(widget._availableAirports);
      });
    }
  }

  Future<List<Airport>> getAvailableDestinationsForDepartureAirport() async {
    List<Airport> airports = [];
    RyanairDataFetcher ryanairDataFetcher = RyanairDataFetcher();
    airports = await ryanairDataFetcher.getAvailableDestinationsForAirport(
        context.read<FlightDetails>().departureAirport!);
    return airports;
  }

  Future<void> setAvailableDestinationsForDepartureAirport() async {
    var airports = await getAvailableDestinationsForDepartureAirport();
    context.read<AvailableDestinations>().setAvailableDestinations(airports);
  }

  void resetArrivalAirport() {
    context.read<FlightDetails>().arrivalAirport = null;
  }

  void setAnywhereDestination() {
    context.read<FlightDetails>().arrivalAirport = Airport(
        name: 'Anywhere', country: '', countryAlpha2Code: '', iataCode: '');
  }

  bool currentDepartureAirportEquals(Airport airport) {
    var currentAirport = context.read<FlightDetails>().departureAirport;
    return currentAirport == airport;
  }

  @override
  void initState() {
    super.initState();
    _availableAirports.addAll(widget._availableAirports);
  }

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterAirportSearchResults(value);
                },
                controller: _editingController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Colors.grey),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                ),
              ),
            ),
            widget._isArrivalAirport
                ? ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Text(
                      '🌍',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    title: Text(
                      'Anywhere',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    onTap: () {
                      setAnywhereDestination();
                      Navigator.pop(context);
                    },
                  )
                : SizedBox.shrink(),
            Expanded(
              child: SingleChildScrollView(
                child: GroupedListView<dynamic, String>(
                  controller: ModalScrollController.of(context),
                  shrinkWrap: true,
                  elements: _availableAirports,
                  groupBy: (airport) => airport.country,
                  groupComparator: (firstCountry, secondCountry) =>
                      secondCountry.compareTo(firstCountry),
                  itemComparator: (firstAirport, secondAirport) =>
                      secondAirport.name.compareTo(
                    firstAirport.name,
                  ),
                  order: GroupedListOrder.DESC,
                  groupSeparatorBuilder: (String country) => Container(
                    child: ListTile(
                      leading: Text(
                        EmojiConverter.fromAlpha2CountryCode(
                            getAlpha2CodeFromCountryName(country)),
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      title: Text(
                        country,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    margin: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                  ),
                  itemBuilder: (context, airport) {
                    return Card(
                      elevation: 3.0,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        title: Text(
                          airport.name,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Text(airport.iataCode),
                        onTap: () async {
                          if (widget._isArrivalAirport) {
                            context.read<FlightDetails>().arrivalAirport =
                                airport;
                          } else {
                            if (!currentDepartureAirportEquals(airport)) {
                              resetArrivalAirport();
                              context.read<FlightDetails>().departureAirport =
                                  airport;
                              EasyLoading.show(status: 'Loading');
                              await setAvailableDestinationsForDepartureAirport();
                              EasyLoading.dismiss();
                            }
                          }
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
