import 'package:Sale_App/adminScreens/showclick.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Sale_App/tools/app_data.dart';

class BTSSlideView extends StatefulWidget {
  @override
  _BTSSlideViewState createState() => _BTSSlideViewState();
}

class _BTSSlideViewState extends State<BTSSlideView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              new StreamBuilder(
                  stream: Firestore.instance.collection(sliderData).snapshots(),
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
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
    List<NetworkImage> images = List<NetworkImage>();
    List titles = List();

    for (int i = 0; i < document[sliderImage].length; i++) {
      images.add(NetworkImage('${document[sliderImage][i]}'));
    }
    for (int i = 0; i < document[sliderTitle].length; i++) {
      titles.add(('${document[sliderTitle][i]}'));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            document[sliderName],
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Times',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new BTSShowClick(
                        title: document[sliderName],
                      )));
            },
            child: Container(
              height: 250,
              child: Carousel(
                boxFit: BoxFit.fill,
                images: images,
                autoplay: true,
                indicatorBgPadding: 1.0,
                dotColor: Colors.transparent,
                dotSize: 4.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
