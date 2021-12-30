import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:intl/intl.dart';
import 'package:travel_finder/constants.dart';

class RyanairEndpointUrlGenerator {
  static const kBaseRyanairUrl = 'https://services-api.ryanair.com/farfnd/3/';
  static const kOneWayUrl = 'oneWayFares?';
  static const kRoundTripUrl = 'roundTripFares?';

  static String generateUrlForAirportAvailableDestinations(Airport airport) {
    double budget = 1000;
    String dateRangeStart = DateFormat('y-MM-dd').format(DateTime.now());
    String dateRangeEnd = DateFormat('y-MM-dd').format(DateTime(
        DateTime.now().year + 1, DateTime.now().month, DateTime.now().day));
    String url =
        '$kBaseRyanairUrl$kOneWayUrl&departureAirportIataCode=${airport.iataCode}&outboundDepartureDateFrom=$dateRangeStart&outboundDepartureDateTo=$dateRangeEnd&priceValueTo=$budget';

    return url;
  }

  static String generateUrlForOneWayFlights(FlightDetails flightDetails) {
    String arrivalAirportSubUrl = flightDetails.arrivalAirport ==
            Airport.anywhereDestination
        ? ''
        : 'arrivalAirportIataCode=${flightDetails.arrivalAirport!.iataCode}&';
    double budget = flightDetails.budget;
    String dateRangeStart =
        DateFormat('y-MM-dd').format(flightDetails.travelDateRange!.start);
    String dateRangeEnd =
        DateFormat('y-MM-dd').format(flightDetails.travelDateRange!.end);
    String url =
        '$kBaseRyanairUrl$kOneWayUrl&departureAirportIataCode=${flightDetails.departureAirport!.iataCode}&${arrivalAirportSubUrl}outboundDepartureDateFrom=$dateRangeStart&outboundDepartureDateTo=$dateRangeEnd&priceValueTo=$budget';

    return url;
  }
}
