import 'dart:convert';
import 'package:http/http.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const baseRyanairApiUrl =
    'https://services-api.ryanair.com/farfnd/3/oneWayFares?&';

enum Currency { EUR, USD, PLN }

class FlightFinder {
  String _departureCity;
  DateTime _departureDateFrom;
  DateTime _departureDateTo;
  Currency _currency;
  int _maxPriceValue;
  List<Airport> _availableAirports = [];

  FlightFinder(
      {required departureCity,
      required departureDateFrom,
      required departureDateTo,
      required currency,
      required maxPriceValue})
      : _departureCity = departureCity,
        _departureDateFrom = departureDateFrom,
        _departureDateTo = departureDateTo,
        _currency = currency,
        _maxPriceValue = maxPriceValue;

  void getAvailableAirports() {
    FirebaseFirestore.instance
        .collection('airports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var airportName = doc['airportName'];
        var country = doc['country'];
        var iataCode = doc['iataCode'];
        Airport airport = Airport(
            airportName: airportName, country: country, iataCode: iataCode);
        _availableAirports.add(airport);
      });
    });
  }
}

class Airport {
  final String _airportName;
  final String _country;
  final String _iataCode;

  Airport({required airportName, required country, required iataCode})
      : _airportName = airportName,
        _country = country,
        _iataCode = iataCode;
}
