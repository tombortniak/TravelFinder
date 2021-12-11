import 'package:flutter/material.dart';
import 'package:travel_finder/models/airport.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:travel_finder/models/arrival_airport.dart';

class AirportSelectionPage extends StatelessWidget {
  final String _countryName;
  final List<Airport> _airports;
  final bool _isArrivalAirport;

  AirportSelectionPage(
      {required countryName, required airports, required isArrivalAirport})
      : _countryName = countryName,
        _airports = airports,
        _isArrivalAirport = isArrivalAirport;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                        subtitle: Text('${_airports[index].iataCode}'),
                        onTap: () {
                          if (_isArrivalAirport) {
                            context
                                .read<ArrivalAirport>()
                                .setAirport(_airports[index]);
                          } else {
                            context
                                .read<DepartureAirport>()
                                .setAirport(_airports[index]);
                          }

                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      ),
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
