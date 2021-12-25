import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TravelFinderTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.black),
    headline2: GoogleFonts.poppins(
        fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.black),
    headline3: GoogleFonts.poppins(
        fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.black),
    headline4: GoogleFonts.poppins(
        fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.black),
    bodyText1: GoogleFonts.poppins(fontSize: 15.0, fontWeight: FontWeight.w400),
  );

  static TextTheme darkTextTheme = TextTheme(
    headline1: GoogleFonts.poppins(
        fontSize: 30.0, fontWeight: FontWeight.w600, color: Colors.white),
    headline2: GoogleFonts.poppins(
        fontSize: 25.0, fontWeight: FontWeight.w500, color: Colors.white),
    headline3: GoogleFonts.poppins(
        fontSize: 20.0, fontWeight: FontWeight.w400, color: Colors.white),
    headline4: GoogleFonts.poppins(
        fontSize: 30.0, fontWeight: FontWeight.w500, color: Colors.white),
    bodyText1: GoogleFonts.poppins(
        fontSize: 15.0, fontWeight: FontWeight.w400, color: Colors.white),
  );

  static ThemeData light() {
    return ThemeData(
      brightness: Brightness.light,
      toggleButtonsTheme: ToggleButtonsThemeData(
        selectedColor: Colors.white,
        textStyle: lightTextTheme.bodyText1,
      ),
      textTheme: lightTextTheme,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      brightness: Brightness.dark,
      textTheme: darkTextTheme,
    );
  }
}
