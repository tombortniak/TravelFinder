import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/components/selection_sheet.dart';
import 'package:travel_finder/services/airports.dart';
import 'dart:collection';

class AirportSelectionPage extends StatelessWidget {
  final List<Airport> _airports;
  SplayTreeMap<String, List<String>> _airportsByCountry =
      SplayTreeMap<String, List<String>>();

  AirportSelectionPage({required airports}) : _airports = airports {
    groupAirportsByCountry();
  }

  void groupAirportsByCountry() {
    for (var airport in _airports) {
      if (!_airportsByCountry.containsKey(airport.country)) {
        _airportsByCountry[airport.country] = [airport.airportName];
      } else {
        _airportsByCountry[airport.country]?.add(airport.airportName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: ListView(
        shrinkWrap: true,
        controller: ModalScrollController.of(context),
        children: ListTile.divideTiles(
            context: context,
            tiles: List.generate(
              _airports.length,
              (index) => ListTile(
                title: Text(_airports[index].airportName),
                subtitle: Text(_airports[index].country),
              ),
            )).toList(),
      ),
    );
  }
}
