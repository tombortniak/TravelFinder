import 'package:travel_finder/models/airport.dart';

abstract class AirportsDatabase {
  Future<List<Airport>> getAvailableAirports();
}
