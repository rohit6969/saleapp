import 'package:Sale_App/tools/app_tools.dart';
import 'package:flutter/material.dart';

class BTSHistory extends StatefulWidget {
  @override
  _BTSHistoryState createState() => _BTSHistoryState();
}

class _BTSHistoryState extends State<BTSHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBars(),
        body: new Center(
          child: new Text(
            'Your orders will appear here',
            style: new TextStyle(fontSize: 25.0),
          ),
        ));
  }
}
