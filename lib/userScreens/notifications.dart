import 'package:flutter/material.dart';

class BTSNotification extends StatefulWidget {
  @override
  _BTSNotificationState createState() => _BTSNotificationState();
}

class _BTSNotificationState extends State<BTSNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Order notifications'),
          centerTitle: false,
        ),
        body: new Center(
            child: new Text(
          'My notifications',
          style: new TextStyle(fontSize: 25.0),
        )));
  }
}
