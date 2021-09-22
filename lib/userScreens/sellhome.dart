import 'package:Sale_App/adminScreens/order_history.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/about.dart';
import 'package:Sale_App/userScreens/history.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:Sale_App/userScreens/profile.dart';
import 'package:Sale_App/userScreens/sellInit.dart';
import 'package:Sale_App/userScreens/sellcat.dart';
import 'package:Sale_App/userScreens/selldetails.dart';
import 'package:Sale_App/userScreens/urgentsell.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'contactus.dart';
import 'lol.dart';

class BTSSellHome extends StatefulWidget {
  @override
  _BTSSellHomeState createState() => _BTSSellHomeState();
}

class _BTSSellHomeState extends State<BTSSellHome> {
  int _currentIndex = 0;
  bool accIsLoggedIn;
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String accName = "";
  String accEmail = "";
  String accStatus = "";
  String accPhotoURL = "";

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
      key: scaffoldKey,
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new BTSUrgent()));
                  },
                  child: Container(
                    width: 120.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Center(
                      child: Text(
                        'Urgent sell',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              new StreamBuilder(
                  stream: firestore
                      .collection(productRequests)
                      .where(pemail, isEqualTo: accEmail)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      //return buildShimmer();
                      return new Center(
                          child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Theme.of(context).primaryColor)));
                    } else {
                      final int dataCount = snapshot.data.documents.length;
                      //print("data count $dataCount");
                      if (dataCount == 0) {
                        return new Container(
                          child: new Center(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.add_to_photos,
                                  color: Colors.black45,
                                  size: 60.0,
                                ),
                                new Text(
                                  "Products",
                                  style: new TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20.0,
                                      fontFamily: 'Segoe'),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "Your products requests will appear here",
                                  style: new TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontFamily: 'Segoe'),
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return new GridView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1, childAspectRatio: 1.5),
                          itemCount: dataCount,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];
                            return buildSell(context, index, document);
                          },
                        );
                      }
                    }
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
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
          // if (index == 0) {
          //   openHome();
          // }
          if (index == 1) {
            openMarket();
          }
        },
      ),
    );
  }

  void openHome() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellHome()));
  }

  void openMarket() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellCat()));
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
}

Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
  List sellImages = document[pImages] as List;
  String price = document[pprice];
  String category = document[pcategory];
  String disc = document[pdiscount];
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new BTSSellDetails(
                sellImages: sellImages,
                sellName: document[pname],
                sellDesc: document[pdescription],
                sellCondition: document[pcondition],
                sellPrice: price,
                sellInfo: document[pinfo],
                sellCategory: category,
                sellID: document.documentID,
                sellDisc: disc,
              )));
    },
    child: Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170.0,
              width: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${sellImages[0]}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0)),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    'Name: ${document[pname]}',
                    style: TextStyle(
                        fontSize: 18.0,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  child: Text(
                    '${document[pcategory]}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Price: ' + 'Rs. $price',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Discount: Rs ' + '$disc',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Urgent Sell: ' + '${document[purgent]}',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Times',
                      color: Colors.red[900],
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  height: 10.0,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
