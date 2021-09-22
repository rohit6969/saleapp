import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/userScreens/checkout.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:flutter/services.dart';

class BTSBuyDetails extends StatefulWidget {
  @override
  _BTSBuyDetailsState createState() => _BTSBuyDetailsState();
}

class _BTSBuyDetailsState extends State<BTSBuyDetails> {
  List<DropdownMenuItem<String>> dropDownCategory;
  String selectedCategory;
  List<String> categoryList = new List();

  TextEditingController nameController = new TextEditingController();
  TextEditingController streetController = new TextEditingController();
  TextEditingController houseController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController zipController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  var formatter = new WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"));
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool rememberMe = false;
  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });
  String accEmail = "";
  String accPhone = "";
  String accID = "";

  String accStreet = "";
  String accCity = "";
  String accCountry = "";

  String accName = "";

  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accEmail = await getStringDataLocally(key: userEmail); //}
    accID = await getStringDataLocally(key: userID);
    accPhone = await getStringDataLocally(key: phoneNumber);
    accName = await getStringDataLocally(key: fullName);

    accStreet = await getStringDataLocally(key: userStreet);
    accCity = await getStringDataLocally(key: userCity);
    accCountry = await getStringDataLocally(key: accCountry);
    nameController.text = accName;
    phoneController.text = accPhone;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    countryController.text = "Nepal";
    categoryList = new List.from(localAddress);
    dropDownCategory = buildAndGetDropDownItems(categoryList);
    selectedCategory = dropDownCategory[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Enter Your Details',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'Times',
                          fontWeight: FontWeight.bold),
                    ),
                    Center(
                      child: InkWell(
                        onTap: () {
                          nameController.text = accName;
                          phoneController.text = accPhone;

                          streetController.text = accStreet;
                          cityController.text = accCity;
                          countryController.text = accCountry;
                        },
                        child: Text(
                          'Get info',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times',
                              color: Colors.blue,
                              fontSize: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                height: 30.0,
                color: Colors.black,
              ),
              productTextField(
                textTitle: "Name",
                textHint: "Enter your Name",
                controller: nameController,
              ),
              productTextField(
                  textTitle: "Address",
                  textHint: "Address",
                  controller: cityController),
              productDropDown(
                  textTitle: "City",
                  selectedItem: selectedCategory,
                  dropDownItems: dropDownCategory,
                  changedDropdownItems: changedDropDownCategory),
              productTextField(
                  textTitle: "Phone",
                  textHint: "Phone number",
                  controller: phoneController,
                  textType: TextInputType.phone),
              Divider(
                height: 40.0,
                color: Colors.black,
              ),
              CheckboxListTile(
                value: rememberMe,
                onChanged: _onRememberMeChanged,
                title: Text(
                  'Use same address for billing',
                  style: TextStyle(fontFamily: 'Segoe', fontSize: 18.0),
                ),
              ),
              appButton(
                  btnText: "Continue",
                  onBtnClick: () {
                    updateData(accID, cityController.text,
                        countryController.text, selectedCategory);
                  },
                  btnPadding: 20.0,
                  btnColor: Theme.of(context).primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  loadValues(var documentID) {
    nameController.text = accName;
    phoneController.text = accPhone;
  }

  Future<void> updateData(
      var documentID, String city, String country, String street) async {
    if (nameController.text == "") {
      showSnackBar("Please enter name", scaffoldKey);
      return;
    }
    if (cityController.text == "") {
      showSnackBar("Please enter city", scaffoldKey);
      return;
    }

    if (phoneController.text == "") {
      showSnackBar("Please enter phone number", scaffoldKey);
      return;
    }

    //displayProgressDialog(context);
    bool result;
    await Firestore.instance
        .collection(usersData)
        .document(documentID)
        .updateData({
      userStreet: street,
      userCity: city,
      userCountry: country
    }).whenComplete(() {
      result = true;
    });
    writeDataLocally(key: userStreet, value: street);

    writeDataLocally(key: userCity, value: city);
    writeDataLocally(key: userCountry, value: country);
   // closeProgressDialog(context);
    if (rememberMe == true) {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new BTSCheckOut(
                street: selectedCategory,
                city: cityController.text,
                country: countryController.text,
              )));
    } else {
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new BTSCheckOut()));
    }
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
    });
  }
}
