import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/pages/airport_country_selection_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/components/selection_sheet.dart';

class FlightSearchField extends StatefulWidget {
  final String _placeholder;
  final FaIcon _icon;
  final VoidCallback _onTap;

  FlightSearchField({required placeholder, required icon, required onTap})
      : _placeholder = placeholder,
        _icon = icon,
        _onTap = onTap;

  @override
  _FlightSearchFieldState createState() => _FlightSearchFieldState();
}

class _FlightSearchFieldState extends State<FlightSearchField> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget._icon,
            SizedBox(
              width: 10.0,
            ),
            Text(
              _value ?? widget._placeholder,
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onTap: widget._onTap,
    );
  }
}
