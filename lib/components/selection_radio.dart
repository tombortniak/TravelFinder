import 'package:flutter/material.dart';

enum FlightType { oneWay, roundTrip }

class SelectionRadio extends StatefulWidget {
  const SelectionRadio({Key? key}) : super(key: key);

  @override
  _SelectionRadioState createState() => _SelectionRadioState();
}

class _SelectionRadioState extends State<SelectionRadio> {
  FlightType? _flighType = FlightType.oneWay;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: const Text(
                'One way',
                style: TextStyle(fontSize: 15.0),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              horizontalTitleGap: 0.0,
              leading: Radio<FlightType>(
                value: FlightType.oneWay,
                groupValue: _flighType,
                onChanged: (FlightType? value) {
                  setState(() {
                    _flighType = value;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: ListTile(
              title: const Text(
                'Round trip',
                style: TextStyle(fontSize: 15.0),
              ),
              horizontalTitleGap: 0.0,
              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
              leading: Radio<FlightType>(
                value: FlightType.roundTrip,
                groupValue: _flighType,
                onChanged: (FlightType? value) {
                  setState(() {
                    _flighType = value;
                  });
                },
              ),
            ),
          )
        ],
      ),
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
