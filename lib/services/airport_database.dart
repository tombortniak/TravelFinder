import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_finder/models/airport.dart';

class AirportDatabase {
  static Future<List<Airport>> getAvailableAirports() async {
    List<Airport> availableAirports = [];
    FirebaseFirestore.instance
        .collection('airports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Airport airport = Airport(
            name: doc['name'],
            country: doc['country'],
            countryAlpha2Code: doc['countryAlpha2Code'],
            iataCode: doc['iataCode']);
        availableAirports.add(airport);
      }
    });
    return availableAirports;
  }
}
