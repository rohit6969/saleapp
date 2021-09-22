import 'package:Sale_App/adminScreens/add_products.dart';
import 'package:Sale_App/adminScreens/addsliders.dart';
import 'package:Sale_App/adminScreens/advertisement.dart';
import 'package:Sale_App/adminScreens/app_products.dart';
import 'package:Sale_App/adminScreens/app_users.dart';
import 'package:Sale_App/adminScreens/newsliderview.dart';
import 'package:Sale_App/adminScreens/offer.dart';
import 'package:Sale_App/adminScreens/requests.dart';
import 'package:Sale_App/adminScreens/search_data.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'adminadd.dart';

class BTSAdminHome extends StatefulWidget {
  @override
  _BTSAdminHomeState createState() => _BTSAdminHomeState();
}

class _BTSAdminHomeState extends State<BTSAdminHome> {
  Size screenSize;
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: new AppBar(
        title: new Text(
          "Admin Panel",
          style: TextStyle(fontFamily: 'Toxia', fontSize: 26.0),
        ),
        elevation: 0.0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            new SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSSearchData()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.search),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Search Data"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSAppUsers()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person_pin),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("App Users"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSAddAdmin()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.person_add),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Add admin"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSAdminRequests()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.playlist_add),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Product Requests"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSAppProducts()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.shop),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("App Products"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSAddProducts()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.add),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Add Products"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSSliderAdd()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.add_to_queue),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Add sliders"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSAdvertisement()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.add_to_home_screen),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Advertisement"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            new SizedBox(height: 20.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (context) => BTSOffer()));
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.add_photo_alternate),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Offers"),
                      ],
                    ),
                  ),
                ),
                new GestureDetector(
                  onTap: () {
                    logout();
                  },
                  child: new CircleAvatar(
                    maxRadius: 70.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Icon(Icons.power_settings_new),
                        new SizedBox(
                          height: 10.0,
                        ),
                        new Text("Logout"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppMethods appMethods = new FirebaseMethods();

  logout() async {
    bool response = await appMethods.logOutUser();
    if (response == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => BTSLogin()),
          ModalRoute.withName('/'));
    }
  }
}
