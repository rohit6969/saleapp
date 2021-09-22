import 'package:Sale_App/adminScreens/adminSearch.dart';
import 'package:Sale_App/adminScreens/search_data.dart';
import 'package:Sale_App/adminScreens/viewslider.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BTSSliderAdd extends StatefulWidget {
  @override
  _BTSSliderAddState createState() => _BTSSliderAddState();
}

class _BTSSliderAddState extends State<BTSSliderAdd> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool accIsLoggedIn;
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  TextEditingController sliderTitle = new TextEditingController();
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
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      if (accIsLoggedIn == true) {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new BTSAdminSearch()));
                      } else {
                        showSnackBar(
                            'Login required to search data', scaffoldKey);
                      }
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
                                fontFamily: 'Times',
                                fontSize: 20.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
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
                height: 20.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new BTSViewSlider()));
                },
                child: Center(
                  child: Text('View sliders',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[700],
                          fontFamily: 'Times',
                          fontSize: 15.0)),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              productTextField(
                  textTitle: "Slider Title",
                  textHint: "Enter Slider Title",
                  controller: sliderTitle),
              SizedBox(
                height: 10.0,
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
              appButton(
                  btnText: "Add Product",
                  onBtnClick: () {
                    addSliders();
                  },
                  btnPadding: 20.0,
                  btnColor: Theme.of(context).primaryColor),
            ],
          ),
        ));
  }

  List<String> doclist = new List();
  List imgList = new List();
  List<String> nameList = new List();

  Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
    List sellImages = document[productImages] as List;
    String price = document[productPrice];

    String category = document[productCategory];
    String disc = document[productDiscount].toString();
    var docID = document.documentID;

    return SingleChildScrollView(
      child: GestureDetector(
        onTap: () {
          print(docID);
        },
        child: Card(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
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
                      height: 15.0,
                    ),
                    InkWell(
                      onTap: () {
                        doclist.add(docID);
                        imgList.add(sellImages[0]);
                        nameList.add(document[productTitle]);
                      },
                      child: Text(
                        'Add to sliders',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold),
                      ),
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
      ),
    );
  }

  AppMethods appMethod = new FirebaseMethods();
  addSliders() async {
    if (imgList.length == 0) {
      showSnackBar('Please select images to display', scaffoldKey);
      return;
    }
    if (doclist.length == 0) {
      showSnackBar('Please select products to display', scaffoldKey);
      return;
    }
    if (nameList.length == 0) {
      showSnackBar('Please select images to display', scaffoldKey);
      return;
    }
    if (sliderTitle.text == "") {
      showSnackBar('Please enter slider title', scaffoldKey);
      return;
    }
    String date = DateTime.now().toString();

    // show progress dialog

    //Get the text from the inidividual controllers title,price, description
    Map<String, dynamic> newProduct = {
      sliderName: sliderTitle.text,
    };
    //Adding the information to firebase
    String productID = await appMethod.addNewSlider(newSlider: newProduct);
    if (imgList.contains(error)) {
      closeProgressDialog(context);
      showSnackBar("Image retrieve Error, contact for support", scaffoldKey);
      return;
    }
    if (nameList.contains(error)) {
      closeProgressDialog(context);
      showSnackBar("Image retrieve Error, contact for support", scaffoldKey);
      return;
    }
    if (doclist.contains(error)) {
      closeProgressDialog(context);
      showSnackBar("Image retrieve Error, contact for support", scaffoldKey);
      return;
    }
    bool result = await appMethod.updateSliderImages(
        docID: productID,
        sliderImages: imgList,
        sliderIDs: doclist,
        sliderDates: date,
        sliderTitles: nameList);
    if (result != null && result == true) {
     // closeProgressDialog(context);
      resetValues();
      showSnackBar('Sliders added successfully', scaffoldKey);
    } else {
      
      showSnackBar("An error occured, contact for support", scaffoldKey);
    }
  }

  resetValues() {
    nameList.clear();
    imgList.clear();
    sliderTitle.text = "";
    doclist.clear();
  }
}
