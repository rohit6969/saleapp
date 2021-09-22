import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/productcarthome.dart';
import 'package:Sale_App/userScreens/productscreen.dart';
import 'package:Sale_App/userScreens/sellhome.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class BTSSellDetails extends StatefulWidget {
  String sellPrice;
  String sellName;
  String sellCategory;
  String sellInfo;
  String sellDesc;
  String sellCondition;
  String sellDisc;
  String sellID;
  List sellImages;
  BTSSellDetails(
      {this.sellPrice,
      this.sellName,
      this.sellCategory,
      this.sellInfo,
      this.sellDesc,
      this.sellCondition,
      this.sellID,
      this.sellDisc,
      this.sellImages});

  @override
  _BTSSellDetailsState createState() => _BTSSellDetailsState();
}

class _BTSSellDetailsState extends State<BTSSellDetails> {
  List<DropdownMenuItem<String>> dropDownCategory;
  String selectedCategory;
  List<String> categoryList = new List();
  Firestore firestore;
  TextEditingController name = new TextEditingController();
  TextEditingController condition = new TextEditingController();
  TextEditingController brand = new TextEditingController();
  TextEditingController description = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    categoryList = new List.from(localCategories);
    dropDownCategory = buildAndGetDropDownItems(categoryList);
    selectedCategory = widget.sellCategory;
  }

  @override
  Widget build(BuildContext context) {
    // setState(() {
    //   name.text = widget.sellName;
    //   brand.text = widget.sellInfo;
    //   description.text = widget.sellDesc;
    // });
    Size screenSize = MediaQuery.of(context).size;
    List<NetworkImage> images = List<NetworkImage>();
    for (int i = 0; i < widget.sellImages.length; i++) {
      images.add(NetworkImage('${widget.sellImages[i]}'));
    }
    Widget image_slider_carousel = Container(
      height: 300,
      child: Carousel(
        boxFit: BoxFit.fill,
        images: images,
        autoplay: true,
        indicatorBgPadding: 1.0,
        dotColor: Colors.grey,
        dotSize: 4.0,
      ),
    );
    return Scaffold(
      appBar: appBars(),
      key: scaffoldKey,
      body: new ListView(
        children: <Widget>[
          image_slider_carousel,
          Divider(
            height: 10.0,
            color: Colors.black,
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  (double.parse(widget.sellPrice) -
                          (double.parse(widget.sellDisc)))
                      .toString(),
                  style: TextStyle(
                      fontSize: 25.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text('Rs. ${widget.sellPrice}',
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Times',
                                decoration: TextDecoration.lineThrough)),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Rs. '+'${widget.sellDisc}',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Times',
                          ),
                        ),
                      ],
                    ),
                    productTextField(
                        controller: name,
                        textHint: 'Your product name',
                        textTitle: 'Name'),
                    SizedBox(
                      height: 5.0,
                    ),
                    productTextField(
                        controller: condition,
                        textHint: 'Your product condition',
                        textTitle: 'Condition'),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                  thickness: 1.0,
                ),
                productTextField(
                  controller: brand,
                  textHint: 'Your product brand',
                  textTitle: 'Brand',
                  maxLines: 6,
                  height: 100.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                  thickness: 1.0,
                ),
                productDropDown(
                    textTitle: "Product Categories",
                    selectedItem: selectedCategory,
                    dropDownItems: dropDownCategory,
                    changedDropdownItems: changedDropDownCategory),
                productTextField(
                  controller: description,
                  textTitle: 'Description',
                  textHint: 'Your product description',
                  maxLines: 4,
                  height: 80.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  height: 10.0,
                  color: Colors.black,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        edit();
                      },
                      child: Container(
                        width: 80.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Segoe',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        updateInfo(widget.sellID, name.text, condition.text,
                            selectedCategory, description.text, brand.text);
                      },
                      child: Container(
                        width: 80.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Segoe',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        delete(widget.sellID);
                      },
                      child: Container(
                        width: 80.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            'Delete',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Segoe',
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                  //color: Colors.black,
                ),
                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      //Rating
                      'Ratings and Reviews' + '(n)',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15.0),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                Divider(height: 40.0, thickness: 1.0, color: Colors.black),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      //Rating
                      'Customer Questions',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 70.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Center(
                        child: Text(
                          'All the Questions with their Answers',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times',
                              fontSize: 18.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void edit() {
    name.text = widget.sellName;
    brand.text = widget.sellInfo;
    description.text = widget.sellDesc;
    condition.text = widget.sellCondition;
    // selectedCategory = widget.sellCategory;
  }

  Future<void> delete(var documentID) async {
    bool result;
    displayProgressDialog(context);
    await Firestore.instance
        .collection(productRequests)
        .document(documentID)
        .delete()
        .whenComplete(() {
      result = true;
    });

    if (result == true) {
      closeProgressDialog(context);
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => new BTSSellHome()));
    }
  }

  Future<void> updateInfo(var documentID, String name, String condition,
      String category, String description, String brand) async {
    bool result;
    if (category == 'Select product category') {
      return;
    }
    await Firestore.instance
        .collection(productRequests)
        .document(documentID)
        .updateData({
      pinfo: brand,
      pcondition: condition,
      pdescription: description,
      pname: name,
      pcategory: category,
    }).whenComplete(() {
      result = true;
      showSnackBar('Information updated successfully', scaffoldKey);
    });
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
    });
  }
}
