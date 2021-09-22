import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSAppProducts extends StatefulWidget {
  @override
  _BTSAppProductsState createState() => _BTSAppProductsState();
}

class _BTSAppProductsState extends State<BTSAppProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBars(),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text('App Products',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Times',
                        fontSize: 25.0)),
              ),
              SizedBox(
                height: 30.0,
              ),
              new StreamBuilder(
                  stream:
                      Firestore.instance.collection(appProducts).snapshots(),
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
                                  "Products",
                                  style: new TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20.0,
                                      fontFamily: 'Segoe'),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "No products exist",
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
        ));
  }

  Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
    List sellImages = document[productImages] as List;
    String price = document[productPrice];
    String category = document[productCategory];
    String disc = document[productDiscount].toString();
    var docID = document.documentID;

    return GestureDetector(
      onTap: () {
        print(docID);
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
                    '$category',
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
                    'Discount: $disc %',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Times',
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    width: 150.0,
                    child: Text(
                      '${document[productEmail]}',
                      style: TextStyle(
                          fontSize: 17.0,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold),
                    ),
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
}
