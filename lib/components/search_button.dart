import 'package:flutter/material.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: Text(
          'Search',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 15.0, color: Colors.black),
        ),
        margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 15.0),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onTap: () {},
    );
  }
}
