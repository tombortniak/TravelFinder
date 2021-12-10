import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AirportSelectionPage extends StatelessWidget {
  final String _countryName;
  final List<Airport> _airports;

  AirportSelectionPage({required countryName, required airports})
      : _countryName = countryName,
        _airports = airports;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            AppBar(
              title: Text(_countryName),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ListView(
                  shrinkWrap: true,
                  controller: ModalScrollController.of(context),
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: List.generate(
                      _airports.length,
                      (index) => ListTile(
                          title: Text(
                            '${_airports[index].name}',
                            style: TextStyle(fontSize: 20.0),
                          ),
                          subtitle: Text('${_airports[index].iataCode}')),
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
