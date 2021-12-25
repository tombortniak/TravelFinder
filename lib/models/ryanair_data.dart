import 'package:travel_finder/models/airport.dart';

class RyanairData {
  final Map<String, dynamic> _data;

  RyanairData({required data}) : _data = data;

  List<Airport> toAvailableDestinationsForAirport() {
    List<Airport> airports = [];
    for (var element in _data['fares']) {
      var airportName = element['outbound']['arrivalAirport']['name'];
      var country = element['outbound']['arrivalAirport']['countryName'];
      var countryAlpha2Code = element['outbound']['arrivalAirport']['city']
              ['countryCode']
          ?.toUpperCase();
      var iataCode = element['outbound']['arrivalAirport']['iataCode'];
      airports.add(
        Airport(
            name: airportName,
            country: country,
            countryAlpha2Code: countryAlpha2Code,
            iataCode: iataCode),
      );
    }
    return airports;
  }
}
