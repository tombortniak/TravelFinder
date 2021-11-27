import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';

class OptionContent extends StatelessWidget {
  final String _title;
  final IconData _icon;

  OptionContent({required title, required icon})
      : _title = title,
        _icon = icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          _icon,
          size: 50.0,
        ),
        Text(
          _title,
          style: kOptionCardTextStyle,
        ),
      ],
    );
  }
}
