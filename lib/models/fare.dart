import 'package:travel_finder/models/flight.dart';

class Fare {
  final Flight outboundFlight;
  final Flight? inboundFlight;

  Fare({required this.outboundFlight, this.inboundFlight});

  factory Fare.fromJson(Map<String, dynamic> data) {
    final outboundFlight = Flight.fromJson(data['outbound']);
    final inboundFlight =
        data['inbound'] != null ? Flight.fromJson(data['inbound']) : null;

    return Fare(outboundFlight: outboundFlight, inboundFlight: inboundFlight);
  }
}
