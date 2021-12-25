const kBaseRyanairUrl = 'https://services-api.ryanair.com/farfnd/3/';
const kOneWayUrl = 'oneWayFares?';
const kRoundTripUrl = 'roundTripFares?';

enum FlightType { oneWay, roundTrip }

final kCalendarFirstDay =
    DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

final kCalendarEndDay =
    DateTime.utc(DateTime.now().year, DateTime.now().month + 6, 30);
