import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/arrival_airport.dart';
import 'package:provider/provider.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_finder/services/json_converter.dart';
import 'package:travel_finder/services/http_manager.dart';
import 'package:travel_finder/constants.dart';
import 'package:travel_finder/models/available_destinations.dart';

class AirportSelectionPage extends StatefulWidget {
  final bool _arrivalAirport;
  final List<Airport> _airports;
  final Map<String, String> _alpha2CodesByCountries = {};

  AirportSelectionPage({required airports, required isArrivalAirport})
      : _airports = airports,
        _arrivalAirport = isArrivalAirport {
    groupCountriesWithAlpha2Codes();
  }

  void groupCountriesWithAlpha2Codes() {
    for (var airport in _airports) {
      if (!_alpha2CodesByCountries.containsKey(airport.country)) {
        _alpha2CodesByCountries[airport.country] = airport.countryAlpha2Code;
      }
    }
  }

  @override
  State<AirportSelectionPage> createState() => _AirportSelectionPageState();
}

class _AirportSelectionPageState extends State<AirportSelectionPage> {
  TextEditingController _editingController = TextEditingController();
  List<Airport> _airports = [];

  String getAlpha2CodeFromCountryName(String countryName) {
    return widget._alpha2CodesByCountries[countryName] ?? '';
  }

  void filterSearchResults(String query) {
    List<Airport> searchList = [];
    searchList.addAll(widget._airports);

    if (query.isNotEmpty) {
      List<Airport> listData = [];

      searchList.forEach((airport) {
        if (airport.name.toLowerCase().contains(query)) {
          listData.add(airport);
        }
      });
      setState(() {
        _airports.clear();
        _airports.addAll(listData);
      });
    } else {
      setState(() {
        _airports.clear();
        _airports.addAll(widget._airports);
      });
    }
  }

  Future<List<Airport>> getAvailableDestinations() async {
    List<Airport> airports = [];
    if (context.read<DepartureAirport>().airport != null) {
      var departureAirportIataCode =
          context.read<DepartureAirport>().airport?.iataCode;

      HttpManager http = HttpManager(
          url:
              '$kBaseRyanairUrl$kOneWayUrl&departureAirportIataCode=$departureAirportIataCode&inboundDepartureDateFrom=2021-12-20&inboundDepartureDateTo=2022-12-20&market=en-gb&outboundDepartureDateFrom=2021-12-20&outboundDepartureDateTo=2022-12-20&priceValueTo=1000');

      var data = await http.getData();
      JsonConverter converter = JsonConverter();
      airports = converter.convertToAirports(data);
    }

    return airports;
  }

  @override
  void initState() {
    super.initState();
    _airports.addAll(widget._airports);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              title: Text('Choose airport'),
              centerTitle: true,
              backgroundColor: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: _editingController,
                decoration: InputDecoration(
                    labelText: 'Search',
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            widget._arrivalAirport
                ? Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      leading: Text(
                        '🌍',
                        style: TextStyle(fontSize: 30.0),
                      ),
                      title: Text(
                        'Anywhere',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        context.read<ArrivalAirport>().setAirport(Airport(
                            name: 'Anywhere',
                            country: '',
                            countryAlpha2Code: '',
                            iataCode: ''));
                        Navigator.pop(context);
                      },
                    ),
                  )
                : SizedBox.shrink(),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: GroupedListView<dynamic, String>(
                    controller: ModalScrollController.of(context),
                    shrinkWrap: true,
                    elements: _airports,
                    groupBy: (airport) => airport['country'],
                    groupComparator: (value1, value2) =>
                        value2.compareTo(value1),
                    itemComparator: (item1, item2) => item2['name'].compareTo(
                      item1['name'],
                    ),
                    order: GroupedListOrder.DESC,
                    groupSeparatorBuilder: (String country) => Container(
                      child: ListTile(
                        leading: Text(
                          EmojiConverter.fromAlpha2CountryCode(
                              getAlpha2CodeFromCountryName(country)),
                          style: TextStyle(fontSize: 30.0),
                        ),
                        title: Text(
                          country,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      margin:
                          EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
                    ),
                    itemBuilder: (context, airport) {
                      return Card(
                        elevation: 4.0,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          title: Text(airport['name']),
                          trailing: Text(airport['iataCode']),
                          onTap: () async {
                            Navigator.pop(context);
                            if (widget._arrivalAirport) {
                              context
                                  .read<ArrivalAirport>()
                                  .setAirport(airport);
                            } else {
                              var currentAirport =
                                  context.read<DepartureAirport>().airport;
                              if (currentAirport != airport) {
                                context
                                    .read<DepartureAirport>()
                                    .setAirport(airport);

                                EasyLoading.show(status: 'Loading');
                                var airports = await getAvailableDestinations();
                                context
                                    .read<AvailableDestinations>()
                                    .setAvailableDestinations(airports);
                                EasyLoading.dismiss();
                              }
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
