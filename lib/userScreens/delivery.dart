import 'package:flutter/material.dart';

class BTSDelivery extends StatefulWidget {
  @override
  _BTSDeliveryState createState() => _BTSDeliveryState();
}

class _BTSDeliveryState extends State<BTSDelivery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Delivery Information'),
          centerTitle: false,
        ),
        body: new Center(
          child: new Text(
            'My delivery address',
            style: new TextStyle(fontSize: 25.0),
          ),
        ));
  }
}
