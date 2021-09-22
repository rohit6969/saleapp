import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/userScreens/checkoutorder.dart';

class BTSCheckOut extends StatefulWidget {
  String street, city, country;
  BTSCheckOut({this.street, this.city, this.country});
  @override
  _BTSCheckOutState createState() => _BTSCheckOutState();
}

class _BTSCheckOutState extends State<BTSCheckOut> {
  TextEditingController shipController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  String accEmail = "";
  String accPhone = "";
  String nametext = "";
  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accEmail = await getStringDataLocally(key: userEmail);
    accPhone = await getStringDataLocally(key: phoneNumber);
    nametext = await getStringDataLocally(key: fullName);
    emailController.text = accEmail;
    phoneController.text = accPhone;
    if (
        widget.street == null ||
        widget.city == null ||
        widget.country == null) {
      addressController.text = '';
    } else {
      addressController.text =
          widget.street + ' , ' + widget.city + ' , ' + widget.country;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Check Out',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Segoe',
                    fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 30.0,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    nametext,
                    style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Segoe'),
                  ),
                  InkWell(
                    onTap: () {
                      getInfo();
                    },
                    child: Text(
                      'Get info',
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Segoe'),
                    ),
                  ),
                ],
              ),
              new SizedBox(height: 10.0),
              productTextField(
                  textTitle: "Shipping",
                  textHint: "Shipping details",
                  controller: shipController,
                  maxLines: 6,
                  height: 120.0),
              new SizedBox(height: 10.0),
              productTextField(
                  textTitle: "Address",
                  textHint: "Bill to the same address",
                  textType: TextInputType.number,
                  controller: addressController),
              new SizedBox(height: 10.0),
              productTextField(
                  textTitle: "Phone Number",
                  textHint: "Phone Number",
                  textType: TextInputType.number,
                  controller: phoneController),
              new SizedBox(height: 10.0),
              productTextField(
                  textTitle: "Email",
                  textHint: "Email Address",
                  textType: TextInputType.number,
                  controller: emailController),
              new SizedBox(height: 10.0),
              Divider(
                height: 20.0,
                color: Colors.black,
              ),
              new StreamBuilder(
                  stream: Firestore.instance
                      .collection(userCart)
                      .where(cartEmail, isEqualTo: accEmail)
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
                          child: new Center(
                            child: new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Icon(
                                  Icons.add_shopping_cart,
                                  color: Colors.black45,
                                  size: 80.0,
                                ),
                                new Text(
                                  "Add to cart",
                                  style: new TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20.0,
                                      fontFamily: 'Segoe'),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "To view items, add them to cart",
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
                                  crossAxisCount: 1, childAspectRatio: 1.65),
                          itemCount: dataCount,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];

                            return buildCard(context, index, document);
                          },
                        );
                      }
                    }
                  }),
              Divider(
                height: 20.0,
                color: Colors.black,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text(
                    'Items',
                    style: TextStyle(fontFamily: 'Segoe'),
                  ),
                  new StreamBuilder(
                      stream: Firestore.instance
                          .collection(userCart)
                          .where(cartEmail, isEqualTo: accEmail)
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
                          return (Text('$dataCount',
                              style: new TextStyle(fontFamily: 'Segoe')));
                        }
                      }),
                ],
              ),
              Divider(
                height: 20.0,
                color: Colors.black,
              ),
              Divider(
                height: 3.0,
                color: Colors.black,
              ),
              SizedBox(height: 10.0),
              Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Subtotal (' + 'n ' + 'items)',
                          style: TextStyle(fontFamily: 'Segoe')),
                      new StreamBuilder(
                          stream: Firestore.instance
                              .collection(userCart)
                              .where(cartEmail, isEqualTo: accEmail)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              //return buildShimmer();
                              return new Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor)));
                            } else {
                              final int dataCount =
                                  snapshot.data.documents.length;
                              //print("data count $dataCount");
                              if (dataCount == 0) {
                                return new Container(
                                  height: 0.0,
                                  width: 0.0,
                                );
                              } else {
                                final sum = snapshot.data.documents.fold(
                                    0,
                                    (previous, next) =>
                                        previous + int.parse(next[cartSum]));
                                return Column(
                                  children: <Widget>[
                                    new Text(
                                      sum.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Segoe',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                          }),
                    ],
                  ),
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Discount", style: TextStyle(fontFamily: 'Segoe')),
                      new StreamBuilder(
                          stream: Firestore.instance
                              .collection(userCart)
                              .where(cartEmail, isEqualTo: accEmail)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              //return buildShimmer();
                              return new Center(
                                  child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).primaryColor)));
                            } else {
                              final int dataCount =
                                  snapshot.data.documents.length;
                              //print("data count $dataCount");
                              if (dataCount == 0) {
                                return new Container(
                                  height: 0.0,
                                  width: 0.0,
                                );
                              } else {
                                final sum = snapshot.data.documents.fold(
                                    0,
                                    (previous, next) =>
                                        previous +
                                        ((int.parse(next[cartDiscount]))));
                                return Column(
                                  children: <Widget>[
                                    new Text(
                                      sum.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Segoe',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                );
                              }
                            }
                          }),
                    ],
                  ),
                  Divider(
                    height: 20.0,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildTotalContainer(),
    );
  }

  getInfo() {
    emailController.text = accEmail;
    phoneController.text = accPhone;
    if (widget.street == null ||
        widget.city == null ||
        widget.country == null) {
      addressController.text = '';
    } else {
      addressController.text =
          widget.street + ' , ' + widget.city + ' , ' + ' , ' + widget.country;
    }
  }

  Widget buildCard(BuildContext context, int index, DocumentSnapshot document) {
    List cartImage = document[cartImages] as List;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 130.0,
              width: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${cartImage[0]}'),
                  fit: BoxFit.cover,
                ),
                //borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0)),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  document[cartTitle],
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Sellers name',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontFamily: 'Segoe',
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Text(
                  'Rs.' +
                      '${int.parse(document[cartPrice]) - (int.parse(document[cartDiscount]))}',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Segoe', fontSize: 12.0),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      'Rs. ${document[cartPrice]}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: 'Segoe',
                          decoration: TextDecoration.lineThrough),
                    ),
                    SizedBox(
                      width: 7.0,
                    ),
                    Text(
                      'Rs. ' + '${document[cartDiscount]}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  'Qty: ' +
                      '${int.parse(document[cartSum]) / int.parse(document[cartPrice])}',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Segoe',
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalContainer() {
    return Container(
      height: 80.0,
      color: Colors.black,
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: <Widget>[
                    Text(
                      "Cart Total:   ",
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Segoe',
                          color: Colors.white),
                    ),
                    new StreamBuilder(
                        stream: Firestore.instance
                            .collection(userCart)
                            .where(cartEmail, isEqualTo: accEmail)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            //return buildShimmer();
                            return new Center(
                                child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Theme.of(context).primaryColor)));
                          } else {
                            final int dataCount =
                                snapshot.data.documents.length;
                            //print("data count $dataCount");
                            if (dataCount == 0) {
                              return new Container(
                                height: 0.0,
                                width: 0.0,
                              );
                            } else {
                              final sum = snapshot.data.documents.fold(
                                  0,
                                  (previous, next) =>
                                      previous +
                                      (int.parse(next[cartSum]) -
                                          (int.parse(next[cartDiscount]))));
                              return new Text(
                                sum.toString(),
                                style: TextStyle(
                                  fontFamily: 'Segoe',
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          }
                        }),
                  ],
                ),
                Text(
                  "VAT included where applicable",
                  style: TextStyle(
                      fontSize: 8.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Segoe',
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            InkWell(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new BTSOrderScreen()));
              },
              child: Container(
                //width: MediaQuery.of(context).size.width,
                width: 130.0,
                height: 70.0,
                decoration: BoxDecoration(
                  color: Colors.teal[300],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Text(
                    'Proceed to Pay',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Segoe',
                        fontSize: 13.0),
                  ),
                ),
              ),
            ),

            //Divider(height: 40.0, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
