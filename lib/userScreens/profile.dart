import 'package:Sale_App/tools/app_tools.dart';
import 'package:flutter/material.dart';

class BTSProfile extends StatefulWidget {
  String name, email, status;
  BTSProfile({this.name, this.email, this.status});

  @override
  _BTSProfileState createState() => _BTSProfileState();
}

class _BTSProfileState extends State<BTSProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Material(
          elevation: 7.0,
          borderRadius: BorderRadius.circular(7.0),
          child: Container(
            height: 300.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Your account',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 1.0,
                  width: double.infinity,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Your name',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.name,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Your email',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.email,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Your status',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.status != null ? widget.status : 'Guest',
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
