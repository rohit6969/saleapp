import 'package:Sale_App/adminScreens/search_data.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/searchClass.dart';
import 'package:Sale_App/userScreens/buyDetails.dart';
import 'package:Sale_App/userScreens/productDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/appmethods.dart';
//Custom widget
import 'ordercart.dart';
import 'package:Sale_App/tools/app_tools.dart';

class BTSCart extends StatefulWidget {
  @override
  _BTSCartState createState() => _BTSCartState();
}

class _BTSCartState extends State<BTSCart> {
  String value = '';
  String total = '';
  String accEmail = '';

  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accEmail = await getStringDataLocally(key: userEmail);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  AppMethods appMethods;
  List<int> cartprice = new List<int>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new BTSSearchData()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.baseline,
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0,
                              fontFamily: 'Segoe',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Subtotal",
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Segoe',
                        color: Colors.grey),
                  ),
                  new StreamBuilder(
                      stream: Firestore.instance
                          .collection(userCart)
                          .where(cartEmail, isEqualTo: accEmail)
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
                              height: 0.0,
                              width: 0.0,
                            );
                          } else {
                            final sum = snapshot.data.documents.fold(
                                0,
                                (previous, next) =>
                                    previous + int.parse(next[cartSum]));
                            return Column(
                              children: <Widget>[
                                new Text(
                                  sum.toString(),
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Segoe',
                                      color: Colors.black),
                                ),
                              ],
                            );
                          }
                        }
                      }),
                ],
              ),
              Divider(height: 40.0, color: Colors.black),
              GestureDetector(
                onTap: () {
                  openDetails();
                },
                child: Container(
                  width: 200.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      'Proceed to Checkout',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Segoe',
                          fontSize: 18.0),
                    ),
                  ),
                ),
              ),
              Divider(height: 40.0, color: Colors.black),
              new StreamBuilder(
                  stream: Firestore.instance
                      .collection(userCart)
                      .where(cartEmail, isEqualTo: accEmail)
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
                                  Icons.add_shopping_cart,
                                  color: Colors.black45,
                                  size: 80.0,
                                ),
                                new Text(
                                  "Add to cart",
                                  style: new TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20.0,
                                      fontFamily: 'Segoe'),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "To view items, add them to cart",
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
                                  crossAxisCount: 1, childAspectRatio: 1.65),
                          itemCount: dataCount,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];

                            return buildCard(context, index, document);
                          },
                        );
                      }
                    }
                  }),
            ],
          ),
        ],
      ),
      //bottomNavigationBar: _buildTotalContainer(),
    );
  }

  int number = 1;
  void _incrementCounter() {
    setState(() {
      number = number + 1;
    });
  }

  void _decrementCounter() {
    if (number > 1) {
      setState(() {
        number = number - 1;
      });
    }
  }

  Widget buildCard(BuildContext context, int index, DocumentSnapshot document) {
    List cartImage = document[cartImages] as List;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 7.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 160.0,
              width: 140.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${cartImage[0]}'),
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
                SizedBox(height: 10.0),
                InkWell(
                  onTap: () {
                    //openDetails();
                  },
                  child: Text(
                    '${document[cartTitle]}',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  height: 20.0,
                  color: Colors.black,
                ),
                Text(
                  'Rs.' + '${document[cartSum]}',
                  style: TextStyle(fontFamily: 'Segoe', color: Colors.grey),
                ),
                SizedBox(height: 10.0),
                Container(
                  //height: 50.0,
                  //width: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  //width: 45.0,
                  //Button column
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            _decrementCounter();
                            total = (number * int.parse(document[cartPrice]))
                                .toString();
                            updateCart(document.documentID, total);
                          },
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          )),
                      Text(
                        '${(int.parse(document[cartSum]) / int.parse(document[cartPrice])).toString()}',
                        style: TextStyle(
                            fontSize: 18.0,
                            //fontFamily: 'Segoe',
                            color: Colors.grey),
                      ),
                      InkWell(
                          onTap: () {
                            _incrementCounter();
                            total = (number * int.parse(document[cartPrice]))
                                .toString();
                            updateCart(document.documentID, total);
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                //SizedBox(height: 10.0),
              ],
            ),
            Spacer(),
            InkWell(
                onTap: () {
                  removeCart(document.documentID);
                },
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  removeCart(var documentID) async {
    bool result;
    await Firestore.instance
        .collection(userCart)
        .document(documentID)
        .delete()
        .whenComplete(() {
      result = true;

      showSnackBar('Items removed from cart', scaffoldKey);
    });
  }

  Future<void> updateCart(var documentID, String price) async {
    bool result;
    await Firestore.instance
        .collection(userCart)
        .document(documentID)
        .updateData({cartSum: price}).whenComplete(() {
      result = true;
    });
  }

  void openDetails() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSBuyDetails()));
  }
}
