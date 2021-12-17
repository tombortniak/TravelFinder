import 'package:travel_finder/models/airport.dart';

class JsonConverter {
  List<Airport> convertToAirports(data) {
    List<Airport> airports = [];
    for (var airportInfo in data['fares']) {
      var airportName = airportInfo['outbound']['arrivalAirport']['name'];
      var country = airportInfo['outbound']['arrivalAirport']['countryName'];
      var countryAlpha2Code = airportInfo['outbound']['arrivalAirport']['city']
              ['countryCode']
          ?.toUpperCase();
      var iataCode = airportInfo['outbound']['arrivalAirport']['iataCode'];
      airports.add(Airport(
          name: airportName,
          country: country,
          countryAlpha2Code: countryAlpha2Code,
          iataCode: iataCode));
    }
    return airports;
  }
}
