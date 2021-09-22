import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/productDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSMarketShow extends StatefulWidget {
  @override
  _BTSMarketShowState createState() => _BTSMarketShowState();
  String category;
  BTSMarketShow(this.category);
}

class _BTSMarketShowState extends State<BTSMarketShow> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              new StreamBuilder(
                  stream: Firestore.instance
                      .collection(appProducts)
                      .where(productCategory, isEqualTo: widget.category)
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
                      print("data count $dataCount");
                      if (dataCount == 0) {
                        return new Container(
                          child: new Center(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.find_in_page,
                                  color: Colors.black45,
                                  size: 80.0,
                                ),
                                new Text(
                                  "Product not available yet",
                                  style: new TextStyle(
                                      color: Colors.black45, fontSize: 20.0),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "Please check back later",
                                  style: new TextStyle(
                                      color: Colors.red, fontSize: 14.0),
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
                  })
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
    List sellImages = document[productImages] as List;
    String price = "3000";
    String category = "Others";
    String disc = "20";
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new HomePage(
                  buyImages: sellImages,
                  buyName: document[productTitle],
                  buyDesc: document[productDesc],
                  buyPrice: price,
                  buyInfo: document[productDesc],
                  buyCategory: document[productCategory],
                  buyDisc: disc,
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
                      'Name: ${document[productTitle]}',
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
                    '${document[productCategory]}',
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
                    'Price: 3000',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    'Discount: 20%',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    height: 10.0,
                    thickness: 1.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
