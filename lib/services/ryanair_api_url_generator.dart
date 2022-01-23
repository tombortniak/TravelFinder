import 'package:travel_finder/models/airport.dart';
import 'package:travel_finder/models/flight_details.dart';
import 'package:intl/intl.dart';

class RyanairApiUrlGenerator {
  static const baseRyanairUrl = 'https://services-api.ryanair.com';
  static const baseRyanairFlightsPerDayUrl =
      'https://www.ryanair.com/api/farfnd/3/roundTripFares';
  static const faresUrl = '/farfnd/3';
  static const cheapestOneWayUrl = '/oneWayFares?';
  static const cheapestRoundTripUrl = '/roundTripFares?';
  static const cheapestFlightsPerDayUrl = '/cheapestPerDay?';

  static String urlForAirportAvailableDestinations(Airport airport) {
    double budget = 1000;
    String dateRangeStart = DateFormat('y-MM-dd').format(DateTime.now());
    String dateRangeEnd = DateFormat('y-MM-dd').format(DateTime(
        DateTime.now().year + 1, DateTime.now().month, DateTime.now().day));
    String url =
        '$baseRyanairUrl$faresUrl$cheapestOneWayUrl&departureAirportIataCode=${airport.iataCode}&outboundDepartureDateFrom=$dateRangeStart&outboundDepartureDateTo=$dateRangeEnd&priceValueTo=$budget';

    return url;
  }

  static String urlForOneWayFlightsPerDay(FlightDetails flightDetails) {
    String dateRangeStart =
        DateFormat('y-MM-dd').format(flightDetails.travelDateRange!.start);
    String dateRangeEnd =
        DateFormat('y-MM-dd').format(flightDetails.travelDateRange!.end);
    String url =
        '$baseRyanairFlightsPerDayUrl/${flightDetails.departureAirport!.iataCode}/${flightDetails.arrivalAirport!.iataCode}${cheapestFlightsPerDayUrl}outboundDateFrom=$dateRangeStart&outboundDateTo=$dateRangeEnd';
    return url;
  }

  static String urlForCheapestOneWayFlights(FlightDetails flightDetails) {
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
        '$baseRyanairUrl$faresUrl$cheapestOneWayUrl&departureAirportIataCode=${flightDetails.departureAirport!.iataCode}&${arrivalAirportSubUrl}outboundDepartureDateFrom=$dateRangeStart&outboundDepartureDateTo=$dateRangeEnd&priceValueTo=$budget';

    return url;
  }

  static String urlForCheapestRoundTripFlights(FlightDetails flightDetails) {
    String arrivalAirportIataCode = flightDetails.arrivalAirport ==
            Airport.anywhereDestination
        ? ''
        : 'arrivalAirportIataCode=${flightDetails.arrivalAirport!.iataCode}&';
    double budget = flightDetails.budget;
    String dateRangeStart =
        DateFormat('y-MM-dd').format(flightDetails.travelDateRange!.start);
    String dateRangeEnd =
        DateFormat('y-MM-dd').format(flightDetails.travelDateRange!.end);
    String url =
        '$baseRyanairUrl$faresUrl$cheapestRoundTripUrl&departureAirportIataCode=${flightDetails.departureAirport!.iataCode}&$arrivalAirportIataCode&inboundDepartureDateFrom=$dateRangeStart&inboundDepartureDateTo=$dateRangeEnd&outboundDepartureDateFrom=$dateRangeStart&outboundDepartureDateTo=$dateRangeEnd&priceValueTo=$budget';

    return url;
  }
}
