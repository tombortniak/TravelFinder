import 'package:cloud_firestore/cloud_firestore.dart';

class FlightFinder {
  List<Airport> _availableAirports = [];

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
