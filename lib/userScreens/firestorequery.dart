import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/userScreens/firestorequeryreview.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BTSFQ extends StatefulWidget {
  @override
  _BTSFQState createState() => _BTSFQState();
}

class _BTSFQState extends State<BTSFQ> {
  bool reviewFlag = false;
  var reviews;
  List datas;
  @override
  void initState() {
    super.initState();
    ReviewService().getLatestReview().then((QuerySnapshot docs) {
      if (docs.documents.isNotEmpty) {
        reviewFlag = true;
        reviews = docs.documents[0].data;
      }
    });
  }

  // appPrint() {
  //   final QuerySnapshot result = ReviewService().getData();
  //   final List<DocumentSnapshot> documents = result.documents;
  //   documents.forEach((data) => print(data));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: new Material(
          elevation: 7.0,
          borderRadius: BorderRadius.circular(7.0),
          child: Container(
            height: 300.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Reviews',
                  style: TextStyle(fontSize: 17.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 0.5,
                  width: double.infinity,
                  color: Colors.red,
                ),
                SizedBox(
                  height: 15.0,
                ),
                Text(
                  'Latest reviews',
                  style: TextStyle(fontSize: 14.0),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Row(
                  children: <Widget>[
                    reviewFlag
                        ? Row(
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 50.0,
                                    width: 50.0,
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 25.0,
                              ),
                              Text(
                                reviews["productTitle"],
                                style: TextStyle(fontSize: 17.0),
                              ),
                            ],
                          )
                        : Text(
                            'Loading Please Wait.. ',
                            style: TextStyle(fontSize: 14.0),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
