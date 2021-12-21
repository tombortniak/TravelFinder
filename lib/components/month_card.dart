import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthCard extends StatelessWidget {
  final DateTime _currentDate;

  MonthCard({required currentDate}) : _currentDate = currentDate;

  get value => _currentDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 60.0,
        child: _currentDate.year == DateTime.now().year
            ? Center(
                child: Text(
                  DateFormat.MMMM().format(
                    DateTime(0, _currentDate.month),
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 13.0),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.MMMM().format(
                      DateTime(0, _currentDate.month),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.0),
                  ),
                  Text(_currentDate.year.toString()),
                ],
              ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      ),
    );
  }
}
