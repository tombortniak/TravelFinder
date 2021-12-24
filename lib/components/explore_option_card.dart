import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';

class ExploreOptionCard extends StatelessWidget {
  final String _title;
  final IconData _icon;
  final VoidCallback _onTap;

  ExploreOptionCard({required title, required icon, required onTap})
      : _title = title,
        _icon = icon,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: Container(
        padding: EdgeInsets.all(5.0),
        width: 150.0,
        height: 150.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              _title,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 15.0,
            ),
            Icon(
              _icon,
              size: 40.0,
              color: Colors.black,
            ),
            SizedBox(
              height: 15.0,
            ),
          ],
        ),
        decoration: BoxDecoration(
            border: Border.all(width: 3.0, color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }
}
