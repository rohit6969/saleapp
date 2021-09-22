

import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/productDetails.dart';
import 'package:Sale_App/userScreens/selldetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BTSSearchDisplay extends StatefulWidget {
  var searchdata;
  BTSSearchDisplay({this.searchdata});
  @override
  _BTSSearchDisplayState createState() => _BTSSearchDisplayState();
}

class _BTSSearchDisplayState extends State<BTSSearchDisplay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new StreamBuilder(
                stream: Firestore.instance
                    .collection(advertisement)
                    .where(advScreen, isEqualTo: 'Product Display')
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
                      return new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          return buildAd(context, index, document);
                        },
                      );
                    }
                  }
                }),
            new StreamBuilder(
                stream: Firestore.instance
                    .collection(appProducts)
                    .where(productTitle, isEqualTo: widget.searchdata)
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
                      noDataFound();
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
    );
  }

  Widget buildAd(BuildContext context, int index, DocumentSnapshot document) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        await launch(document[advLink]);
      },
      child: new Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: new Container(
          width: screenSize.width,
          height: 170.0,
          child: FittedBox(
              fit: BoxFit.cover,
              child: new Image.network(document[advImages][0])),
        ),
      ),
    );
  }
}

Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
  List sellImages = document[productImages] as List;
  String price = document[productPrice];
  String category = document[productCategory];
  String disc = document[productDiscount];
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
                  'Price: '+'$price',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Discount: $disc',
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
