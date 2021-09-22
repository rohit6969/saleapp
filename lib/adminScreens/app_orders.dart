import 'package:flutter/material.dart';

class BTSAppOrders extends StatefulWidget {
  @override
  _BTSAppOrdersState createState() => _BTSAppOrdersState();
}

class _BTSAppOrdersState extends State<BTSAppOrders> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('App Orders'),
          centerTitle: false,
        ),
        body: new Center(
          child: new Text(
            'App Orders',
            style: new TextStyle(fontSize: 25.0),
          ),
        ));
  }
}