import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/userScreens/about.dart';
import 'package:Sale_App/userScreens/history.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:Sale_App/userScreens/profile.dart';
import 'package:Sale_App/userScreens/sellFinal.dart';
import 'package:Sale_App/userScreens/sellhome.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'contactus.dart';
import 'lol.dart';
import 'myHomePage.dart';

class BTSSellInit extends StatefulWidget {
  String categories;
  BTSSellInit(this.categories);
  @override
  _BTSSellInitState createState() => _BTSSellInitState();
}

class _BTSSellInitState extends State<BTSSellInit> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    conditionList = new List.from(localCondition);
    dropDownCondition = buildAndGetDropDownItems(conditionList);
    selectedCondition = dropDownCondition[0].value;
  }

  int _currentIndex = 1;
  TextEditingController productName = new TextEditingController();

  TextEditingController productWarranty = new TextEditingController();
  TextEditingController productColor = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  AppMethods appMethods = new FirebaseMethods();
//Condition
  List<DropdownMenuItem<String>> dropDownCondition;
  String selectedCondition;
  List<String> conditionList = new List();

  String accName = "";
  String accEmail = "";
  String accStatus = "";
  String accPhotoURL = "";
  String accID = "";
  bool accIsLoggedIn;
  String usersStatus;

  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accName = await getStringDataLocally(key: fullName);
    accEmail = await getStringDataLocally(key: userEmail);
    accPhotoURL = await getStringDataLocally(key: photoURL);
    accIsLoggedIn = await getBoolDataLocally(key: loggedIn);
    accStatus = await getStringDataLocally(key: userStatus);

    //accStatus == 'Seller' || accStatus=='Both' ? usersStatus = 'Sell' : usersStatus = 'Buy';
    accName == null ? accName = "Guest User" : accName;
    accEmail == null ? accEmail = "guestuser@email.com" : accEmail;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: sellBars(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('Seller',
                  style: TextStyle(
                      fontSize: 34.0,
                      fontFamily: 'Times',
                      fontWeight: FontWeight.bold)),
            ),
            new SizedBox(
              height: 30.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: Colors.black,
                ),
              ),
            ),
            productTextField(
              textTitle: 'Name',
              controller: productName,
              textHint: 'Enter product Name',
            ),
            productDropDown(
                textTitle: "Condition",
                selectedItem: selectedCondition,
                dropDownItems: dropDownCondition,
                changedDropdownItems: changedDropDownCondition),
            productTextField(
              textTitle: 'Quantity',
              controller: productWarranty,
              textHint: 'Enter product quantity(or dimensions)',
            ),
            productTextField(
              textTitle: 'Overview',
              controller: productColor,
              textHint: 'Enter product overview(color or outlook)',
            ),
            new SizedBox(
              height: 40.0,
              child: new Center(
                child: new Container(
                  margin: new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                  height: 2.0,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  verifyInit();
                },
                child: Container(
                  width: 200.0,
                  height: 70.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Times',
                          fontSize: 26.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  verifyInit() async {
    if (productName.text == "") {
      showSnackBar('Please enter product name', scaffoldKey);
      return;
    }
    if (selectedCondition == "Select product condition") {
      showSnackBar('Please select product condition', scaffoldKey);
      return;
    }

    if (productWarranty.text == "") {
      showSnackBar('Please enter product dimensions/quantity', scaffoldKey);
      return;
    }
    if (productColor.text == "") {
      showSnackBar('Please enter product color', scaffoldKey);
      return;
    }

//    displayProgressDialog(context);
    // await appMethods.sellInit(
    //     pname: productName.text,
    //     condition: productCondition.text,
    //     warranty: productWarranty.text,
    //     color: productColor.text);
    //closeProgressDialog(context);
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellFinal(
              name: productName.text,
              color: productColor.text,
              warranty: productWarranty.text,
              category: widget.categories,
              condition: selectedCondition,
              useremail: accEmail,
            )));
  }

  checkIfLoggedIn() async {
    if (accIsLoggedIn == false) {
      bool response = await Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new BTSLogin()));
      if (response == true) getCurrentUser();
      return;
    }
    bool response = await appMethods.logOutUser();
    if (response == true) getCurrentUser();
  }

  void resetFields() {
    productName.text = "";
    selectedCondition = dropDownCondition[0].value;
    productColor.text = "";
    productWarranty.text = "";
    setState(() {});
  }

  void changedDropDownCondition(String selectedSize) {
    setState(() {
      selectedCondition = selectedSize;
    });
  }

  checkStatus() {
    getCurrentUser();
    if (accStatus == 'Seller') {
      showSnackBar('To view market, you must be a buyer', scaffoldKey);
    } else if (accStatus == 'Both') {
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new BTSLol()));
    }
  }
}
