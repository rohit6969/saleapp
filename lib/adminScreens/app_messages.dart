import 'package:flutter/material.dart';

class BTSAppMessages extends StatefulWidget {
  @override
  _BTSAppMessagesState createState() => _BTSAppMessagesState();
}

class _BTSAppMessagesState extends State<BTSAppMessages> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('App Messages'),
          centerTitle: false,
        ),
        body: new Center(
          child: new Text(
            'App Messages',
            style: new TextStyle(fontSize: 25.0),
          ),
        ));
  }
}