import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String _title;

  OptionCard({required title}) : _title = title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        child: Text(_title),
        padding: EdgeInsets.all(50.0),
      ),
      color: Colors.blueGrey,
      margin: EdgeInsets.all(15.0),
    );
  }
}
