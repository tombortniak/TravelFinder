import 'package:flutter/material.dart';

class SelectionSheet extends StatefulWidget {
  final Widget _child;

  SelectionSheet({required child}) : _child = child;

  @override
  _SelectionSheetState createState() => _SelectionSheetState();
}

class _SelectionSheetState extends State<SelectionSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CloseButton(),
                ],
              ),
              widget._child
            ],
          )),
    );
  }
}
