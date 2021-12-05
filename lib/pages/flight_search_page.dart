import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:travel_finder/components/selection_radio.dart';
import 'package:travel_finder/pages/airport_selection_page.dart';
import 'package:travel_finder/components/selection_button.dart';
import 'package:travel_finder/components/search_button.dart';

class FlightSearchPage extends StatefulWidget {
  const FlightSearchPage({Key? key}) : super(key: key);

  @override
  _FlightSearchPageState createState() => _FlightSearchPageState();
}

class _FlightSearchPageState extends State<FlightSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          AppBar(
            title: Text('Flight search'),
          ),
          Container(
            color: Colors.blue,
            child: Column(
              children: [
                SelectionButton(
                  placeholder: 'Departure airport',
                  icon: FaIcon(
                    FontAwesomeIcons.planeDeparture,
                    color: Colors.grey,
                  ),
                ),
                SelectionButton(
                  placeholder: 'Arrival airport',
                  icon: FaIcon(
                    FontAwesomeIcons.planeArrival,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: SelectionButton(
                        placeholder: 'Departure date',
                        icon: FaIcon(
                          FontAwesomeIcons.calendar,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SelectionButton(
                        placeholder: 'Return date',
                        icon: FaIcon(
                          FontAwesomeIcons.calendar,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(flex: 3, child: SelectionRadio()),
                    Expanded(
                      flex: 1,
                      child: SearchButton(),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
