import 'package:flutter/material.dart';
import 'package:travel_finder/constants.dart';

class Button extends StatelessWidget {
  final String _text;
  final Color _backgroundColor;
  final Color _textColor;
  final VoidCallback _onPressed;

  Button(
      {required text,
      required backgroundColor,
      required textColor,
      required onPressed})
      : _text = text,
        _backgroundColor = backgroundColor,
        _textColor = textColor,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text(
          _text,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: _textColor),
        ),
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          primary: _backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          padding: EdgeInsets.all(15.0),
        ),
      ),
    );
  }
}
