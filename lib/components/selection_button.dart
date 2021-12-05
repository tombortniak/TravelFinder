import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/components/selection_sheet.dart';

class SelectionButton extends StatefulWidget {
  final String _placeholder;
  final FaIcon _icon;

  SelectionButton({required placeholder, required icon})
      : _placeholder = placeholder,
        _icon = icon;

  @override
  _SelectionButtonState createState() => _SelectionButtonState();
}

class _SelectionButtonState extends State<SelectionButton> {
  String? _value;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            widget._icon,
            SizedBox(
              width: 10.0,
            ),
            Text(
              _value ?? widget._placeholder,
              style: TextStyle(color: Colors.grey, fontSize: 15.0),
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onTap: () {
        showMaterialModalBottomSheet(
          context: context,
          builder: (context) => AirportSelectionPage(),
          expand: false,
          isDismissible: false,
        );
      },
    );
  }
}
