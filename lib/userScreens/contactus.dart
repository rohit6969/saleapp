import 'package:Sale_App/tools/app_tools.dart';
import 'package:flutter/material.dart';

class BTSContact extends StatefulWidget {
  @override
  _BTSContactState createState() => _BTSContactState();
}

class _BTSContactState extends State<BTSContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact us'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              productText(),
              SizedBox(
                height: 30.0,
              ),
              new Text('Contact Us Through Facebook Page : Lets Business'),
              SizedBox(
                height: 30.0,
              ),
              new Text(' Page : Buy To sell'),
              SizedBox(
                height: 30.0,
              ),
              new Text('Group : 2nd hand buy & sell in Nepal'),
              SizedBox(
                height: 30.0,
              ),
              new Text(' Phone : +977 9849847941(10am T o4pm)'),
              SizedBox(
                height: 30.0,
              ),
              new Text('Working days (Sun To Fri)'),
              SizedBox(
                height: 30.0,
              ),
              new Text('Email : chalisebibek15@gmail.com'),
            ],
          ),
        ),
      ),
    );
  }
}
