import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_finder/models/arrival_airport.dart';
import 'package:travel_finder/models/available_destinations.dart';
import 'package:travel_finder/models/departure_airport.dart';
import 'package:travel_finder/pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DepartureAirport(),
      ),
      ChangeNotifierProvider(
        create: (_) => ArrivalAirport(),
      ),
      ChangeNotifierProvider(
        create: (_) => AvailableDestinations(),
      )
    ],
    child: const App(),
  ));
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..userInteractions = false;
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      builder: EasyLoading.init(),
    );
  }
}
