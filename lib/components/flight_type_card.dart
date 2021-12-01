import 'package:flutter/material.dart';

class FlightTypeCard extends StatelessWidget {
  final String _title;
  final VoidCallback _onTap;

  FlightTypeCard({required title, required onTap})
      : _title = title,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        child: Center(
          child: Text(
            _title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0),
        padding: EdgeInsets.all(20.0),
      ),
    );
  }
}
