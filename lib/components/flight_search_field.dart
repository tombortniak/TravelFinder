import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FlightSearchField extends StatefulWidget {
  final Widget _text;
  final FaIcon _icon;
  final VoidCallback _onTap;

  FlightSearchField({required text, required icon, required onTap})
      : _text = text,
        _icon = icon,
        _onTap = onTap;

  @override
  State<FlightSearchField> createState() => _FlightSearchFieldState();
}

class _FlightSearchFieldState extends State<FlightSearchField> {
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
            widget._text,
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.0),
        padding: EdgeInsets.all(25.0),
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
