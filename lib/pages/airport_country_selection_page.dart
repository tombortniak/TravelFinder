import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:collection';
import 'package:emoji_flag_converter/emoji_flag_converter.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/country.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';

class AirportCountrySelectionPage extends StatelessWidget {
  final List<Airport> _airports;
  SplayTreeMap<Country, List<Airport>> _airportsByCountry =
      SplayTreeMap<Country, List<Airport>>();

  AirportCountrySelectionPage({required airports}) : _airports = airports {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
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
                    tiles: List.generate(
                      _airportsByCountry.keys.toList().length,
                      (index) => ListTile(
                          leading: Text(
                            '${EmojiConverter.fromAlpha2CountryCode(_airportsByCountry.keys.toList()[index].alpha2Code)}',
                            style: TextStyle(fontSize: 40.0),
                          ),
                          title: Text(
                            '${_airportsByCountry.keys.toList()[index].name}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AirportSelectionPage(
                                        countryName: _airportsByCountry.keys
                                            .toList()[index]
                                            .name,
                                        airports: _airportsByCountry[
                                            _airportsByCountry.keys
                                                .toList()[index]])));
                          }),
                    ),
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
