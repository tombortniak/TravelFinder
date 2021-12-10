import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_finder/models/airport.dart';

class AirportFinder {
  List<Airport> _availableAirports = [];

  Future<List<Airport>> getAvailableAirports() async {
    final QuerySnapshot result =
        await FirebaseFirestore.instance.collection('airports').get();
    final List<DocumentSnapshot> documents = result.docs;

    documents.forEach((doc) {
      var airportName = doc['name'];
      var country = doc['country'];
      var countryAlpha2Code = doc['countryAlpha2Code'];
      var iataCode = doc['iataCode'];
      Airport airport = Airport(
          name: airportName,
          country: country,
          countryAlpha2Code: countryAlpha2Code,
          iataCode: iataCode);
      _availableAirports.add(airport);
    });

    return _availableAirports;
  }
}
