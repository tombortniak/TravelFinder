import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import 'theme.dart';
import 'models/models.dart';
import 'pages/pages.dart';
import 'navigation/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AppStateManager(),
      ),
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

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final _appStateManager = AppStateManager();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = TravelFinderTheme.light();
    return MaterialApp(
      home: Router(
        routerDelegate: _appRouter,
      ),
      theme: theme,
      builder: EasyLoading.init(),
    );
  }
}
