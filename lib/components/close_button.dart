import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CloseButton extends StatelessWidget {
  const CloseButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: FaIcon(FontAwesomeIcons.timesCircle),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
