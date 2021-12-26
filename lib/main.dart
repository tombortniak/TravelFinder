import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:travel_finder/models/available_destinations.dart';
import 'package:travel_finder/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'package:travel_finder/models/flight_details.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => FlightDetails(),
      ),
      ChangeNotifierProvider(
        create: (_) => AvailableDestinations(),
      ),
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
    final theme = TravelFinderTheme.light();
    return MaterialApp(
      home: HomePage(),
      theme: theme,
      builder: EasyLoading.init(),
    );
  }
}
