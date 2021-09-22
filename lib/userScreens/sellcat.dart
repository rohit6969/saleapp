import 'package:Sale_App/adminScreens/order_history.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/about.dart';
import 'package:Sale_App/userScreens/contactus.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:Sale_App/userScreens/marketshow.dart';
import 'package:Sale_App/userScreens/profile.dart';
import 'package:Sale_App/userScreens/sellInit.dart';
import 'package:Sale_App/userScreens/sellerhistory.dart';
import 'package:Sale_App/userScreens/sellhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lol.dart';

class BTSSellCat extends StatefulWidget {
  @override
  _BTSSellCatState createState() => _BTSSellCatState();
}

class _BTSSellCatState extends State<BTSSellCat> {
  int _currentIndex = 1;
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String accName = "";
  String accEmail = "";
  String accStatus = "";
  String accPhotoURL = "";
  bool accIsLoggedIn;
  String usersStatus;
  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accName = await getStringDataLocally(key: fullName);
    accEmail = await getStringDataLocally(key: userEmail);
    accPhotoURL = await getStringDataLocally(key: photoURL);
    accIsLoggedIn = await getBoolDataLocally(key: loggedIn);
    accStatus = await getStringDataLocally(key: userStatus);

    //accStatus == 'Seller' || accStatus=='Both' ? usersStatus = 'Sell' : usersStatus = 'Buy';
    accName == null ? accName = "Guest User" : accName;
    accEmail == null ? accEmail = "guestuser@email.com" : accEmail;

    setState(() {});
  }

  checkStatus() {
    getCurrentUser();
    if (accStatus == 'Seller') {
      showSnackBar('To view market, you must be a buyer', scaffoldKey);
    } else if (accStatus == 'Both') {
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new BTSLol()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: sellBars(context),
      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            SizedBox(height: 70.0),

            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            // new UserAccountsDrawerHeader(
            //   accountName: new Text(accName),
            //   accountEmail: new Text(accEmail),
            //   currentAccountPicture: new CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: new Icon(Icons.person),
            //   ),
            // ),

            new ListTile(
              // leading: new CircleAvatar(
              //   child: new Icon(
              //     Icons.shopping_basket,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'Market',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                checkStatus();
              },
            ),
            new ListTile(
              title: new Text(
                'Your account',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSProfile(
                          name: accName,
                          email: accEmail,
                          status: accStatus,
                        )));
              },
            ),
            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),

            new ListTile(
              title: new Text(
                'About us',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSAbout()));
              },
            ),
            new ListTile(
              // trailing: new CircleAvatar(
              //   child: new Icon(
              //     Icons.phone,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'Contact us',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                //print(accIsLoggedIn);
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSContact()));
              },
            ),
            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            new ListTile(
              // trailing: new CircleAvatar(
              //   child: new Icon(
              //     Icons.exit_to_app,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                "Logout",
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                checkIfLoggedIn();
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new BTSLogin()));
              },
            ),
            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
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
                  childAspectRatio: 0.775,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                new BTSSellInit('Electronics')));
                      },
                      child: Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/12.jpg',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Electronics',
                                style: TextStyle(
                                    fontFamily: 'Toxia',
                                    fontSize: 20.0,
                                    color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    new InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new BTSSellInit('Mobiles')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/16.jpg',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Mobiles',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                new BTSSellInit('Bikes and Cars')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/18.jpg',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Bikes and Cars',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new BTSSellInit('Fashion')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/13.png',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Fashion',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                new BTSSellInit('Lands and Buildings')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/11.jpg',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Lands',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) =>
                                new BTSSellInit('Sports and Outdoors')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/19.jpg',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Sports',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new BTSSellInit('Services')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/17.png',
                                height: 150.0,
                                //width: 300.0,
                                fit: BoxFit.contain),
                            new Divider(
                              thickness: 1.0,
                              height: 30.0,
                              color: Colors.black,
                            ),
                            Center(
                              child: new Text(
                                'Services',
                                style: TextStyle(
                                    fontSize: 20.0,
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
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (context) => new BTSSellInit('Others')));
                      },
                      child: new Card(
                        elevation: 10.0,
                        shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(20.0)),
                        child: new ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            new Image.asset('lib/img/15.png',
                                height: 150.0,
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
                                    fontSize: 20.0,
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
            icon: Icon(Icons.shop_two),
            title: Text('Products'),
          ),
          //backgroundColor: Colors.green),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on),
            title: Text('Sell'),
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

  checkIfLoggedIn() async {
    if (accIsLoggedIn == false) {
      bool response = await Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new BTSLogin()));
      if (response == true) getCurrentUser();
      return;
    }

    bool response = await appMethods.logOutUser();
    if (response == true) getCurrentUser();
  }

  void openHome() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellHome()));
  }

  void openMarket() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellCat()));
  }
}
