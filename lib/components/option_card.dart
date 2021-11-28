import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';

class OptionCard extends StatelessWidget {
  final String _title;
  final AssetImage _image;

  OptionCard({required title, required image})
      : _title = title,
        _image = image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 20.0,
        )
      ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(
              left: 10.0,
              right: 10.0,
            ),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              _title,
              style: kOptionCardTextStyle,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                ),
                image: DecorationImage(
                  image: _image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
