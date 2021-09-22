import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/sellInit.dart';
import 'package:Sale_App/userScreens/sellcat.dart';
import 'package:Sale_App/userScreens/sellhome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSSellHistory extends StatefulWidget {
  @override
  _BTSSellHistoryState createState() => _BTSSellHistoryState();
}

class _BTSSellHistoryState extends State<BTSSellHistory> {
  String accEmail = "";
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
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    return Scaffold(
      appBar: appBars(),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            new StreamBuilder(
                stream: Firestore.instance
                    .collection(appProducts)
                    .where(productEmail, isEqualTo: accEmail)
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
                                "Your added products will appear here",
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
                      return new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
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
            Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            SizedBox(height: 10.0),
            Card(
                elevation: 5.0,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Number of Products :',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.bold),
                            ),
                            new StreamBuilder(
                                stream: Firestore.instance
                                    .collection(appProducts)
                                    .where(productEmail, isEqualTo: accEmail)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    //return buildShimmer();
                                    return new Center(
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Theme.of(context)
                                                        .primaryColor)));
                                  } else {
                                    final int dataCount =
                                        snapshot.data.documents.length;
                                    //print("data count $dataCount");
                                    return (Text(
                                      dataCount.toString(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Segoe',
                                          fontWeight: FontWeight.bold),
                                    ));
                                  }
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Number of Requests :',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.bold),
                            ),
                            new StreamBuilder(
                                stream: Firestore.instance
                                    .collection(productRequests)
                                    .where(pemail, isEqualTo: accEmail)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    //return buildShimmer();
                                    return new Center(
                                        child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Theme.of(context)
                                                        .primaryColor)));
                                  } else {
                                    final int dataCount =
                                        snapshot.data.documents.length;
                                    //print("data count $dataCount");
                                    return (Text(
                                      dataCount.toString(),
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontFamily: 'Segoe',
                                          fontWeight: FontWeight.bold),
                                    ));
                                  }
                                }),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      )),
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
          if (index == 0) {
            openHome();
          }
          if (index == 1) {
            openMarket();
          }
        },
      ),
    );
  }

  Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
    List sellImages = document[productImages] as List;
    String price = document[productPrice];
    String category = document[productCategory];
    String disc = document[productDiscount];
    return GestureDetector(
      onTap: () {},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Row(
            children: <Widget>[
              Container(
                height: 120.0,
                width: 80.0,
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
                      'Name: ${document[productTitle]}',
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
                      '${document[productDesc]}',
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
                    '$category',
                    style: TextStyle(
                        fontSize: 18.0,
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

  void openHome() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellHome()));
  }

  void openMarket() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellCat()));
  }
}
