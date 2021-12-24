import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBaseRyanairUrl = 'https://services-api.ryanair.com/farfnd/3/';
const kOneWayUrl = 'oneWayFares?';
const kRoundTripUrl = 'roundTripFares?';

final appThemeData = ThemeData(
  primaryColor: Colors.purple,
  fontFamily: GoogleFonts.poppins().fontFamily,
  textTheme: const TextTheme(
    headline1: TextStyle(
        fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline2: TextStyle(
        fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.black),
    headline3: TextStyle(
        fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
    bodyText1: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
  ),
);

enum FlightType { oneWay, roundTrip }

final kCalendarFirstDay =
    DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

final kCalendarEndDay =
    DateTime.utc(DateTime.now().year, DateTime.now().month + 6, 30);
