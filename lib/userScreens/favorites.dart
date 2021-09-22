import 'package:flutter/material.dart';

class BTSFav extends StatefulWidget {
  @override
  _BTSFavState createState() => _BTSFavState();
}

class _BTSFavState extends State<BTSFav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('My Favorites'),
        centerTitle: false,
      ),
      body: new Center(
          child: new Text(
        'My Favorites',
        style: new TextStyle(fontSize: 25.0),
      )),
    );
  }
}
