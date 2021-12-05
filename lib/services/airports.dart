import 'package:cloud_firestore/cloud_firestore.dart';

class AirportFinder {
  List<Airport> _availableAirports = [];

  Future<List<Airport>> getAvailableAirports() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('airports').get();
    final List<DocumentSnapshot> documents = result.docs;

    documents.forEach((doc) {
      var airportName = doc['airportName'];
      var country = doc['country'];
      var iataCode = doc['iataCode'];
      Airport airport = Airport(
          airportName: airportName, country: country, iataCode: iataCode);
      _availableAirports.add(airport);
    });

    return _availableAirports;
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

  String get airportName => _airportName;
  String get country => _country;
  String get iataCode => _iataCode;
}
