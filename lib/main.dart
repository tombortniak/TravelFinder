import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travel_finder/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MainPage();
  }
}
