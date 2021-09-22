import 'dart:io';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BTSUrgent extends StatefulWidget {
  @override
  _BTSUrgentState createState() => _BTSUrgentState();
}

class _BTSUrgentState extends State<BTSUrgent> {
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String accID = "";
  String accEmail = "";
  int discount;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    categoryList = new List.from(localCategories);
    dropDownCategory = buildAndGetDropDownItems(categoryList);
    selectedCategory = dropDownCategory[0].value;
    conditionList = new List.from(localCondition);
    dropDownCondition = buildAndGetDropDownItems(conditionList);
    selectedCondition = dropDownCondition[0].value;
  }

  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accID = await getStringDataLocally(key: userID);
    accEmail = await getStringDataLocally(key: userEmail);
    setState(() {});
  }

  List<DropdownMenuItem<String>> dropDownCategory;
  String selectedCategory;
  List<String> categoryList = new List();
  List<DropdownMenuItem<String>> dropDownCondition;
  String selectedCondition;
  List<String> conditionList = new List();
  String imageUrl;

  TextEditingController productName = new TextEditingController();
  TextEditingController productColor = new TextEditingController();
  TextEditingController productWarranty = new TextEditingController();
  TextEditingController productInfo = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  TextEditingController productDes = new TextEditingController();
  TextEditingController productDis = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new RaisedButton.icon(
                      color: Colors.green,
                      shape: new RoundedRectangleBorder(
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0))),
                      onPressed: () => pickImage(),
                      icon: Icon(Icons.add, color: Colors.white),
                      label: new Text("Add Images",
                          style: new TextStyle(
                            color: Colors.white,
                            fontFamily: 'Times',
                          ))),
                ),
              ),
              MultiImagePickerList(
                  imageList: imageList,
                  removeNewImage: (index) {
                    removeImage(index);
                  }),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'Urgent sell',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontFamily: 'Times',
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                  child: Text(
                '* Additional charges applied for Urgent Sell * ',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 10.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900]),
              )),
              new SizedBox(
                height: 30.0,
                child: new Center(
                  child: new Container(
                    margin:
                        new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
              urgentText(
                controller: productName,
                textTitle: 'Name',
                textHint: 'Enter product name',
              ),
              productDropDown(
                  textTitle: "Product condition",
                  selectedItem: selectedCondition,
                  dropDownItems: dropDownCondition,
                  changedDropdownItems: changedDropDownCondition),
              urgentText(
                controller: productWarranty,
                textTitle: 'Info',
                textHint: 'Enter product quantity(or dimensions)',
              ),
              Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              urgentText(
                controller: productColor,
                textTitle: 'Overview',
                textHint: 'Enter product outlook(or color)',
              ),
              productDropDown(
                  textTitle: "Product Categories",
                  selectedItem: selectedCategory,
                  dropDownItems: dropDownCategory,
                  changedDropdownItems: changedDropDownCategory),
              Divider(
                thickness: 1.0,
                color: Colors.black,
              ),
              urgentText(
                controller: productInfo,
                textTitle: 'Brand/Model',
                textHint: 'Enter product information (Brand/Model)',
              ),
              urgentText(
                controller: productPrice,
                textTitle: 'Price',
                textHint: 'Enter product price',
                textType: TextInputType.number,
              ),
              urgentText(
                textTitle: 'Discount',
                controller: productDis,
                textHint: 'Enter product discount',
                textType: TextInputType.number,
              ),
              new SizedBox(
                height: 20.0,
                child: new Center(
                  child: new Container(
                    margin:
                        new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 1.0,
                    color: Colors.black,
                  ),
                ),
              ),
              urgentText(
                textTitle: 'Description',
                controller: productDes,
                textHint: 'Enter product description',
                maxLines: 6,
                height: 100.0,
              ),
              new SizedBox(
                height: 20.0,
                child: new Center(
                  child: new Container(
                    margin:
                        new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 1.0,
                    color: Colors.black,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    requestAdd();
                  },
                  child: Container(
                    width: 150.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Center(
                      child: Text(
                        'Post',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Times',
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppMethods appMethod = new FirebaseMethods();
  int price;

  requestAdd() async {
    String tempDis;
    if (productDis.text == "") {
      tempDis = "0";
      discount = int.parse(tempDis);
    } else {
      discount = int.parse(productDis.text);
      price = int.parse(productPrice.text);
      if (discount < 0 || discount >= price) {
        showSnackBar('Please enter valid discount', scaffoldKey);
        return;
      }
    }
    // }
    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Image(s) are required!", scaffoldKey);
      return;
    }
    if (productName.text == "") {
      showSnackBar('Please add product name', scaffoldKey);
      return;
    }
    if (productColor.text == "") {
      showSnackBar('Please add product overview', scaffoldKey);
      return;
    }

    if (productWarranty.text == "") {
      showSnackBar('Please add product quantity', scaffoldKey);
      return;
    }

    if (productInfo.text == "") {
      showSnackBar('Please add product info', scaffoldKey);
      return;
    }
    if (productPrice.text == "") {
      showSnackBar('Please add product price', scaffoldKey);
      return;
    }
    if (productDes.text == "") {
      showSnackBar('Please add product description', scaffoldKey);
      return;
    }
    if (selectedCategory == "Select product category") {
      showSnackBar("Please select a category", scaffoldKey);
      return;
    }
    if (selectedCondition == "Select product condition") {
      showSnackBar("Please select product condition", scaffoldKey);
      return;
    }
    if (productPrice.text.contains(" ")) {
      showSnackBar('Please enter valid price', scaffoldKey);
      return;
    }

    Map<String, dynamic> newRequest = {
      pname: productName.text,
      pcolor: productColor.text,
      pcondition: selectedCondition,
      pwarranty: productWarranty.text,
      pcategory: selectedCategory,
      pinfo: productInfo.text,
      pprice: productPrice.text,
      pdescription: productDes.text,
      purgent: 'Yes',
      pemail: accEmail,
      pdiscount: discount.toString(),
    };
   // displayProgressDialog(context);

    String requestID =
        await appMethod.requestProductAdd(newRequest: newRequest);
    List<String> imagesURL =
        await appMethod.requestImage(imageList: imageList, docID: requestID);
    if (imagesURL.contains(error)) {
     // closeProgressDialog(context);
      showSnackBar("Image upload Error, contact for support", scaffoldKey);
      return;
    }
    //Update information after image upload
    bool result =
        await appMethod.updateReqImage(docID: requestID, data: imagesURL);

    if (result != null && result == true) {
      //closeProgressDialog(context);
      resetFields();
      showSnackBar('Products added successfully', scaffoldKey);
    } else {
      //closeProgressDialog(context);
      //showSnackBar("An error occured, contact for support", scaffoldKey);
    }

    resetFields();
    showSnackBar('Urgent sell requested successfully!', scaffoldKey);
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
    });
  }

  void changedDropDownCondition(String selectedSize) {
    setState(() {
      selectedCondition = selectedSize;
    });
  }

  List<File> imageList;
  final _picker = ImagePicker();
  PickedFile image;
  pickImage() async {
    image = await _picker.getImage(source: ImageSource.camera);
    var file = File(image.path);

    if (file != null) {
      List<File> imageFile = new List();
      imageFile.add(file);
      if (imageList == null) {
        imageList = new List.from(imageFile, growable: true);
      } else {
        for (int s = 0; s < imageFile.length; s++) {
          imageList.add(file);
        }
      }
      setState(() {});
    }
  }

  removeImage(int index) async {
    imageList.removeAt(index);
    setState(() {});
  }

  void resetFields() {
    imageList.clear();
    productInfo.text = "";
    productDes.text = "";
    productPrice.text = "";
    productWarranty.text = "";
    productColor.text = "";
    productName.text = "";
    selectedCondition = dropDownCondition[0].value;
    selectedCategory = dropDownCategory[0].value;
    productDis.text = "";
    setState(() {});
  }
}
