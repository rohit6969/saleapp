import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/buyDetails.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
  List buyImages;
  String buyPrice;
  String buyName;
  String buyCategory;
  String buyInfo;
  String buyDesc;
  String buyDisc;
  HomePage(
      {this.buyName,
      this.buyCategory,
      this.buyInfo,
      this.buyDesc,
      this.buyPrice,
      this.buyDisc,
      this.buyImages});
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  AppMethods appMethods = new FirebaseMethods();
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
    List<NetworkImage> images = List<NetworkImage>();
    for (int i = 0; i < widget.buyImages.length; i++) {
      images.add(NetworkImage('${widget.buyImages[i]}'));
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
      body: ListView(
        children: <Widget>[
          image_slider_carousel,
          Divider(
            height: 10.0,
            color: Colors.black,
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rs. ' +
                          (double.parse(widget.buyPrice) -
                                  (double.parse(widget.buyDisc)))
                              .toString(),
                      style: TextStyle(
                          fontSize: 25.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text('Rs. ' + widget.buyPrice,
                            style: TextStyle(
                                fontSize: 15.0,
                                fontFamily: 'Times',
                                decoration: TextDecoration.lineThrough)),
                        SizedBox(
                          width: 15.0,
                        ),
                        Text(
                          '- Rs. '+widget.buyDisc,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Times',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Name of the product',
                          style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          //Enter here
                          widget.buyName,
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Times',
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Rating',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(height: 10.0, thickness: 1.0, color: Colors.black),
                Divider(height: 3.0, thickness: 1.0, color: Colors.black),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      'Brand/Model',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      widget.buyInfo,
                      style: TextStyle(
                        fontFamily: 'Times',
                      ),
                    ),
                  ],
                ),
                Divider(height: 10.0, thickness: 1.0, color: Colors.black),
                Divider(height: 3.0, thickness: 1.0, color: Colors.black),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      widget.buyDesc,
                      style: TextStyle(
                        fontFamily: 'Times',
                      ),
                    ),
                  ],
                ),
                Divider(height: 20.0, thickness: 1.0, color: Colors.black),
                SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    Text(
                      'Services',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      'Services given by seller',
                      style: TextStyle(
                        fontFamily: 'Times',
                      ),
                    ),
                  ],
                ),
                Divider(height: 40.0, thickness: 1.0, color: Colors.black),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        addCart();
                      },
                      child: Container(
                        width: 130.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Text(
                            'Add to cart',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Segoe',
                                fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    GestureDetector(
                      onTap: () {
                        addCart();
                        if (addCart() != null) {
                          Navigator.of(context).push(new MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new BTSBuyDetails()));
                        }
                      },
                      child: Container(
                        width: 130.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1.0),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Center(
                          child: Text(
                            'Buy Now',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Segoe',
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(height: 40.0, thickness: 1.0, color: Colors.black),
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
                          'View all Questions & Answers',
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
                Divider(
                  height: 40.0,
                  color: Colors.black,
                  thickness: 1.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Similar products',
                      style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 130.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.buyImages[0]),
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
                        ),
                        SizedBox(width: 40.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                //openDetails();
                              },
                              child: Text(
                                widget.buyName,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Segoe',
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Rs.' + '${widget.buyPrice}',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontFamily: 'Segoe',
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(height: 10.0),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    addCart();
                                  },
                                  child: Container(
                                    width: 80.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Add to cart',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Segoe',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 10.0),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                GestureDetector(
                                  onTap: () {
                                    addCart();
                                    if (addCart() != null) {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  new BTSBuyDetails()));
                                    }
                                  },
                                  child: Container(
                                    width: 80.0,
                                    height: 30.0,
                                    decoration: BoxDecoration(
                                      border: Border.all(width: 1.0),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Buy Now',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Segoe',
                                            fontSize: 10.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  addCart() async {
    Map<String, dynamic> newProduct = {
      cartTitle: widget.buyName,
      cartPrice: widget.buyPrice,
      cartDesc: widget.buyDesc,
      cartSum: widget.buyPrice,
      cartDiscount: widget.buyDisc,
      cartCategory: widget.buyCategory,
      cartImages: widget.buyImages,
      cartEmail: accEmail,
      cartQuantity: '1'
    };
    showSnackBar('Items added to cart', scaffoldKey);
    bool result;
    await appMethods.addCart(newCart: newProduct).whenComplete(() {
      result = true;
    });
  }
}
