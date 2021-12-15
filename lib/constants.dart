import 'package:flutter/material.dart';

const kTitleTextStyle = TextStyle(
  fontSize: 30.0,
  fontWeight: FontWeight.bold,
);

const kOptionCardTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.white,
  fontWeight: FontWeight.w600,
);

const kFlightDetailsTitleTextStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

final kCalendarFirstDay =
    DateTime.utc(DateTime.now().year, DateTime.now().month, 1);

final kCalendarEndDay =
    DateTime.utc(DateTime.now().year, DateTime.now().month + 6, 30);
