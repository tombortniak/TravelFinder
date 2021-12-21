import 'package:flutter/material.dart';

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
        child: Text(_text),
        onPressed: _onPressed,
        style: ElevatedButton.styleFrom(
          primary: _backgroundColor,
          onPrimary: _textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          padding: EdgeInsets.all(15.0),
        ),
      ),
    );
  }
}
