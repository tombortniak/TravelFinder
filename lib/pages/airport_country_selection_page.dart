import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:collection';
import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/country.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/models/arrival_airport.dart';
import 'package:provider/provider.dart';

class AirportCountrySelectionPage extends StatelessWidget {
  final bool _isArrivalAirport;
  final List<Airport> _airports;
  final SplayTreeMap<Country, List<Airport>> _airportsByCountry =
      SplayTreeMap<Country, List<Airport>>();

  AirportCountrySelectionPage({required airports, required isArrivalAirport})
      : _airports = airports,
        _isArrivalAirport = isArrivalAirport {
    groupAirportsByCountry();
  }

  void groupAirportsByCountry() {
    for (var airport in _airports) {
      var country =
          Country(name: airport.country, alpha2Code: airport.countryAlpha2Code);
      if (!_airportsByCountry.containsKey(country)) {
        _airportsByCountry[country] = [airport];
      } else {
        _airportsByCountry[country]?.add(airport);
      }
    }
  }

  List<ListTile> generateListTiles(BuildContext context) {
    var customListTile = ListTile(
      leading: Text(
        '🌐',
        style: TextStyle(fontSize: 40.0),
      ),
      title: Text(
        'Anywhere',
        style: TextStyle(fontSize: 20.0),
      ),
      onTap: () {
        context.read<ArrivalAirport>().setAirport(Airport(
            name: 'Anywhere',
            country: '',
            countryAlpha2Code: '',
            iataCode: ''));
        Navigator.pop(context);
      },
    );

    var airports = _airportsByCountry.keys.toList();

    var listTiles = List.generate(
      airports.length,
      (index) => ListTile(
          leading: Text(
            '${EmojiConverter.fromAlpha2CountryCode(airports[index].alpha2Code)}',
            style: TextStyle(fontSize: 40.0),
          ),
          title: Text(
            '${airports[index].name}',
            style: TextStyle(fontSize: 20.0),
          ),
          onTap: () {
            showMaterialModalBottomSheet(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (context) => AirportSelectionPage(
                      countryName: airports[index].name,
                      airports: _airportsByCountry[airports[index]],
                      isArrivalAirport: _isArrivalAirport,
                    ));
          }),
    );
    _isArrivalAirport ? listTiles.insert(0, customListTile) : listTiles;

    return listTiles;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              title: Text('Countries'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  controller: ModalScrollController.of(context),
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: generateListTiles(context),
                  ).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
