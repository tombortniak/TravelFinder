import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_finder/models/airport.dart';
import 'airports_database.dart';

class RyanairAirportsDatabase implements AirportsDatabase {
  Future<List<Airport>> getAvailableAirports() async {
    List<Airport> availableAirports = [];
    FirebaseFirestore.instance
        .collection('airports')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Airport airport = Airport(
            name: doc['name'],
            countryName: doc['countryName'],
            countryAlpha2Code: doc['countryAlpha2Code'],
            iataCode: doc['iataCode']);
        availableAirports.add(airport);
      }
    });
    return availableAirports;
  }
}
