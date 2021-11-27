import 'package:flutter/material.dart';
import 'option_content.dart';

class OptionCard extends StatelessWidget {
  final OptionContent _optionContent;

  OptionCard({required optionContent}) : _optionContent = optionContent;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _optionContent,
        ],
      ),
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(15.0)),
    );
  }
}
