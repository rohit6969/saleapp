import 'package:Sale_App/adminScreens/requests.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/productcarthome.dart';
import 'package:Sale_App/userScreens/productscreen.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:Sale_App/tools/appmethods.dart';

class BTSAdminAdd extends StatefulWidget {
  String sellPrice;
  String sellName;
  String sellCategory;
  String sellInfo;
  String sellEmail;
  var sellID;
  String sellDesc;
  String sellDisc;
  List sellImages;
  BTSAdminAdd(
      {this.sellPrice,
      this.sellName,
      this.sellCategory,
      this.sellEmail,
      this.sellInfo,
      this.sellID,
      this.sellDesc,
      this.sellDisc,
      this.sellImages});

  @override
  _BTSAdminAddState createState() => _BTSAdminAddState();
}

class _BTSAdminAddState extends State<BTSAdminAdd> {
  List<DropdownMenuItem<String>> dropDownCategory;
  String selectedCategory;
  List<String> categoryList = new List();

  TextEditingController name = new TextEditingController();
  TextEditingController brand = new TextEditingController();
  TextEditingController description = new TextEditingController();
  TextEditingController prices = new TextEditingController();
  TextEditingController discounts = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  AppMethods appMethods = new FirebaseMethods();

  @override
  void initState() {
    super.initState();
    categoryList = new List.from(localCategories);
    dropDownCategory = buildAndGetDropDownItems(categoryList);
    selectedCategory = dropDownCategory[0].value;
    name.text = widget.sellName;
    description.text = widget.sellDesc;
    discounts.text = widget.sellDisc;
    prices.text = widget.sellPrice;
    brand.text = widget.sellInfo;
  }

  @override
  Widget build(BuildContext context) {
    double fPrice = double.parse(widget.sellPrice) -
        ((double.parse(widget.sellPrice) * (double.parse(widget.sellDisc))) /
            100);
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
      key: scaffoldKey,
      appBar: appBars(),
      body: new ListView(
        children: <Widget>[
          InkWell(
              onTap: () {
                name.text = widget.sellName;
                brand.text = widget.sellInfo;
                description.text = widget.sellDesc;
                prices.text = widget.sellPrice;
                discounts.text = widget.sellDisc;
                selectedCategory = widget.sellCategory;
              },
              child: image_slider_carousel),
          Divider(
            thickness: 1.0,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  fPrice.toString(),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(widget.sellPrice,
                            style: TextStyle(
                                fontSize: 15.0,
                                decoration: TextDecoration.lineThrough)),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          'Rs. ' + widget.sellDisc,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ],
                    ),
                    productTextField(
                      textTitle: 'Name',
                      textHint: 'Name of the product',
                      controller: name,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
                productTextField(
                  controller: brand,
                  textTitle: 'Brand',
                  textHint: 'Brand/Model',
                  maxLines: 6,
                  height: 100.0,
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.black,
                ),
                productTextField(
                  controller: prices,
                  textTitle: 'Price',
                  textHint: 'Product Price',
                  textType: TextInputType.number,
                ),
                productTextField(
                  controller: discounts,
                  textTitle: 'Discount',
                  textHint: 'Product discount (0-100)',
                  textType: TextInputType.number,
                ),
                Divider(
                  height: 10.0,
                  thickness: 1.0,
                  color: Colors.black,
                ),
                productDropDown(
                    textTitle: "Product Categories",
                    selectedItem: selectedCategory,
                    dropDownItems: dropDownCategory,
                    changedDropdownItems: changedDropDownCategory),
                productTextField(
                  controller: description,
                  textHint: 'Description',
                  textTitle: 'Description',
                  maxLines: 4,
                  height: 80.0,
                ),
                SizedBox(
                  height: 10.0,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        addProducts();
                      },
                      child: Container(
                        width: 120.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Center(
                          child: Text(
                            'Add product',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0),
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
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15.0),
                    InkWell(
                        onTap: () {},
                        child: Text(
                          'View all',
                          style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                Divider(
                  height: 40.0,
                  color: Colors.black,
                  thickness: 1.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      //Rating
                      'Customer Questions',
                      style: TextStyle(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
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
                  color: Colors.black,
                  thickness: 1.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String date = DateTime.now().toString();

  int discountz;
  int pricez;
  loadInfo() {
    name.text = widget.sellName;
    brand.text = widget.sellInfo;
    description.text = widget.sellDesc;
    prices.text = widget.sellPrice;
    discounts.text = widget.sellDisc;
    selectedCategory = widget.sellCategory;
  }

  addProducts() async {
    if (name.text == "") {
      showSnackBar("Please add product name", scaffoldKey);
      return;
    }
    if (brand.text == "") {
      showSnackBar("Please add brand name", scaffoldKey);
      return;
    }
    if (description.text == "") {
      showSnackBar("Please add product description", scaffoldKey);
      return;
    }
    if (prices.text == "") {
      showSnackBar("Please add product price", scaffoldKey);
      return;
    }
    String tempDis;
    if (discounts.text == "") {
      tempDis = "0";
      discountz = int.parse(tempDis);
    } else {
      discountz = int.parse(discounts.text);
      pricez = int.parse(prices.text);
      if (discountz < 0 || discountz >= pricez) {
        showSnackBar('Please enter valid discount', scaffoldKey);
        return;
      }
    }
    if (prices.text.contains(" ")) {
      showSnackBar('Please enter valid price', scaffoldKey);
      return;
    }

    if (selectedCategory == "Select product category") {
      showSnackBar("Please select product category", scaffoldKey);
      return;
    }
    //displayProgressDialog(context);
    Map<String, dynamic> newProduct = {
      productTitle: name.text,
      productPrice: prices.text,
      productDiscount: discountz,
      productDesc: description.text,
      productCategory: selectedCategory,
      productDate: date,
      productEmail: widget.sellEmail,
      productImages: widget.sellImages,
      searchKey: name.text.substring(0, 1),
    };
    String productID = await appMethods.addNewProduct(newProduct: newProduct);
    bool result;
    await Firestore.instance
        .collection(productRequests)
        .document(widget.sellID)
        .delete()
        .whenComplete(() {
      result = true;
      showSnackBar(
          'Requests accepted, products added successfully', scaffoldKey);
    });
    if (result == true) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new BTSAdminRequests()));
    }
    //closeProgressDialog(context);
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
      print(selectedSize);
    });
  }
}
