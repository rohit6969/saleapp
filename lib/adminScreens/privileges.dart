import 'package:flutter/material.dart';

class BTSPrivileges extends StatefulWidget {
  @override
  _BTSPrivilegesState createState() => _BTSPrivilegesState();
}

class _BTSPrivilegesState extends State<BTSPrivileges> {
  @override
 Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: new Text('Privileges'),
          centerTitle: false,
        ),
        body: new Center(
          child: new Text(
            'Privileges',
            style: new TextStyle(fontSize: 25.0),
          ),
        ));
  }
}