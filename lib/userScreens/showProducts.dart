import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/productDetails.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSShowProducts extends StatefulWidget {
  //String showcase;
  BTSShowProducts();
  @override
  _BTSShowProductsState createState() => _BTSShowProductsState();
}

class _BTSShowProductsState extends State<BTSShowProducts> {
  bool accIsLoggedIn;
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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0,),
              Center(
                  child: Text(
                'Recently listed products',
                style: TextStyle(
                    fontFamily: 'Times',
                    fontSize: 23.0,
                    fontWeight: FontWeight.bold),
              )),
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
                        return new ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: dataCount,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];
                            return buildScreen(context, index, document);
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

  Widget buildScreen(
      BuildContext context, int index, DocumentSnapshot document) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Container(
          child: GridView.builder(
            itemCount: document[sliderImage].length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.80,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return buildGrid(context, index, document);
            },
          ),
        )
      ],
    );
    // return new Container(
    //   child: new Column(
    //     children: <Widget>[
    //       Container(
    //         decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: NetworkImage('${document[sliderImage]}'),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  Widget buildGrid(BuildContext context, int index, DocumentSnapshot document) {
    return GestureDetector(
      onTap: () async {
        DocumentSnapshot variable = await Firestore.instance
            .collection(appProducts)
            .document(document[sliderID][index])
            .get();

        if (accIsLoggedIn == true) {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage(
                    buyName: variable[productTitle],
                    buyCategory: variable[productCategory],
                    buyDesc: variable[productDesc],
                    buyDisc: variable[productDiscount],
                    buyImages: variable[productImages],
                    buyInfo: variable[productDesc],
                    buyPrice: variable[productPrice],
                  )));
        } else {
          showSnackBar('Login required to access information', scaffoldKey);
          return;
        }
      },
      child: new Container(
        child: new Card(
          elevation: 10.0,
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(10.0)),
          child: new Column(
            children: <Widget>[
              new Image.network(document[sliderImage][index],
                  height: 180.0, width: 200.0, fit: BoxFit.fill),
              // Divider(
              //   thickness: 1.0,
              //   color: Colors.black,
              // ),
              new Text(
                document[sliderTitle][index],
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
