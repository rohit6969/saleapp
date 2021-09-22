import 'package:Sale_App/adminScreens/productadd.dart';
import 'package:Sale_App/adminScreens/search_firebase.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/sellInit.dart';
import 'package:Sale_App/userScreens/selldetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:Sale_App/tools/app_tools.dart';

class BTSAdminRequests extends StatefulWidget {
  @override
  _BTSAdminRequestsState createState() => _BTSAdminRequestsState();
}

class _BTSAdminRequestsState extends State<BTSAdminRequests> {
  int _currentIndex = 0;
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Center(
                  child: Text('Product requests',
                      style: TextStyle(
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold,
                          fontSize: 30.0))),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              new StreamBuilder(
                  stream: firestore.collection(productRequests).snapshots(),
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
                                  Icons.group_add,
                                  color: Colors.black45,
                                  size: 80.0,
                                ),
                                new Text(
                                  "Requests",
                                  style: new TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20.0,
                                      fontFamily: 'Segoe'),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "No requests exist",
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
                                  crossAxisCount: 1, childAspectRatio: 1.75),
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
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 1,
      //   backgroundColor: Colors.teal[700],
      //   iconSize: 30,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.shop_two),
      //       title: Text('Products'),
      //     ),
      //     //backgroundColor: Colors.green),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.monetization_on),
      //       title: Text('Sell'),
      //     )
      //     // backgroundColor: Colors.green),
      //   ],
      //   onTap: (index) {
      //     setState(() {
      //       _currentIndex = index;
      //     });
      //     if (index == 0) {
      //       openMarket();
      //     }
      //     if (index == 1) {
      //       openHome();
      //     }
      //   },
      // ),
    );
  }

  void openMarket() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSAdminRequests()));
  }
}

Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
  List sellImages = document[pImages] as List;
  String price = document[pprice];
  String category = document[pcategory];
  String disc = document[pdiscount].toString();
  var docID = document.documentID;

  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (context) => new BTSAdminAdd(
                sellImages: sellImages,
                sellName: document[pname],
                sellDesc: document[pdescription],
                sellPrice: price,
                sellID: docID,
                sellEmail: document[pemail],
                sellInfo: document[pinfo],
                sellCategory: category,
                sellDisc: disc,
              )));
    },
    child: Card(
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
                        fontSize: 20.0,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  '${document[pcondition]}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Times',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Rs. $price',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Discount: Rs. '+' $disc',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Times',
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
