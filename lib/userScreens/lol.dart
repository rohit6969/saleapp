import 'package:Sale_App/adminScreens/search_data.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/marketshow.dart';

import 'package:flutter/material.dart';

import 'myHomePage.dart';

class BTSLol extends StatefulWidget {
  @override
  _BTSLolState createState() => _BTSLolState();
}

class _BTSLolState extends State<BTSLol> {
  int _currentIndex = 1;
  bool accIsLoggedIn;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future getCurrentUser() async {
    accIsLoggedIn = await getBoolDataLocally(key: loggedIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text('Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Times',
                      fontSize: 30.0)),
              SizedBox(
                height: 30.0,
              ),
              Container(
                child: GridView.count(
                  childAspectRatio: 0.90,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 1,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if (accIsLoggedIn == true) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  new BTSMarketShow('Electronics')));
                        } else {
                          showSnackBar(
                              'Cannot access marketplace if not logged in!',
                              scaffoldKey);
                          return;
                        }
                      },
                      child: Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: 300.0,
                              child: new Image.asset('lib/img/12.jpg',

                                  //width: 300.0,
                                  fit: BoxFit.fill),
                            ),
                            new Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Electronics',
                                style: TextStyle(
                                    fontFamily: 'Toxia',
                                    fontSize: 25.0,
                                    color: Colors.grey),
                              ),
                            ),
                            SizedBox(
                              height: 30.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {
                        if (accIsLoggedIn == true) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  new BTSMarketShow('Mobiles')));
                        } else {
                          showSnackBar(
                              'Cannot access marketplace if not logged in!',
                              scaffoldKey);
                          return;
                        }
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: 300.0,
                              child: new Image.asset('lib/img/16.jpg',

                                  //width: 300.0,
                                  fit: BoxFit.fill),
                            ),
                            new Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Mobiles',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Toxia',
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {
                        if (accIsLoggedIn == true) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  new BTSMarketShow('Bikes and Cars')));
                        } else {
                          showSnackBar(
                              'Cannot access marketplace if not logged in!',
                              scaffoldKey);
                          return;
                        }
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: 300.0,
                              child: new Image.asset('lib/img/18.jpg',

                                  //width: 300.0,
                                  fit: BoxFit.cover),
                            ),
                            new Divider(
                              thickness: 1.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Bikes and Cars',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Toxia',
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {
                        if (accIsLoggedIn == true) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  new BTSMarketShow('Fashion')));
                        } else {
                          showSnackBar(
                              'Cannot access marketplace if not logged in!',
                              scaffoldKey);
                          return;
                        }
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Container(
                              height: 300.0,
                              child: new Image.asset('lib/img/13.png',

                                  //width: 300.0,
                                  fit: BoxFit.fill),
                            ),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Fashion',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Toxia',
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {
                        if (accIsLoggedIn == true) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (context) =>
                                  new BTSMarketShow('Others')));
                        } else {
                          showSnackBar(
                              'Cannot access marketplace if not logged in!',
                              scaffoldKey);
                          return;
                        }
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/15.png',
                                height: 300.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Others',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontFamily: 'Toxia',
                                    color: Colors.grey),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.teal[700],
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          //backgroundColor: Colors.green),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('Market'),
          )
          // backgroundColor: Colors.green),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 0) {
            openHome();
          }
          // if (index == 1) {
          //   openMarket();
          // }
        },
      ),
    );
  }

  void openHome() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new MyHomePage()));
  }

  void openMarket() {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) => new BTSLol()));
  }
}
