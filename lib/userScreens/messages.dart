import 'package:flutter/material.dart';

class BTSMessages extends StatefulWidget {
  @override
  _BTSMessagesState createState() => _BTSMessagesState();
}

class _BTSMessagesState extends State<BTSMessages> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Messages'),
        centerTitle: false,
      ),
      body: new Center(
          child: new Text(
            'My Messages', 
            style: new TextStyle(fontSize: 25.0))),
    );
  }
}
