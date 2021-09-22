import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sale_App/tools/app_data.dart';

class BTSOrderScreen extends StatefulWidget {
  @override
  _BTSOrderScreenState createState() => _BTSOrderScreenState();
}

class _BTSOrderScreenState extends State<BTSOrderScreen> {
  bool accIsLoggedIn;
  String accID, accEmail;
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  Future getCurrentUser() async {
    accIsLoggedIn = await getBoolDataLocally(key: loggedIn);
    accID = await getStringDataLocally(key: userID);
    accID = await getStringDataLocally(key: userEmail);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              'Order',
              style: TextStyle(
                  fontFamily: 'Times',
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            GestureDetector(
              onTap: () {
                print(accIsLoggedIn);
                showSnackBar('Order received', scaffoldKey);
              },
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 100.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Icon(
                            Icons.location_on,
                            color: Colors.black,
                            size: 20.0,
                          ),
                          Text(
                            ' Cash on Delivery',
                            style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
