import 'package:Sale_App/tools/app_tools.dart';
import 'package:flutter/material.dart';

class BTSOrderHistory extends StatefulWidget {
  @override
  _BTSOrderHistoryState createState() => _BTSOrderHistoryState();
}

class _BTSOrderHistoryState extends State<BTSOrderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBars(),
        body: new Center(
          child: new Text(
            'Order History will appear here',
            style: new TextStyle(
                fontSize: 20.0,
                fontFamily: 'Segoe',
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
