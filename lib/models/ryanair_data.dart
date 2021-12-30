import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/flight.dart';

class RyanairData {
  final Map<String, dynamic> data;

  RyanairData({required this.data});

  List<Airport> toArrivalAirports() {
    List<Airport> airports = [];
    for (var element in data['fares']) {
      var airportName = element['outbound']['arrivalAirport']['name'];
      var country = element['outbound']['arrivalAirport']['countryName'];
      var countryAlpha2Code = element['outbound']['arrivalAirport']['city']
              ['countryCode']
          ?.toUpperCase();
      var iataCode = element['outbound']['arrivalAirport']['iataCode'];
      airports.add(
        Airport(
            name: airportName,
            countryName: country,
            countryAlpha2Code: countryAlpha2Code,
            iataCode: iataCode),
      );
    }
    return airports;
  }
}
