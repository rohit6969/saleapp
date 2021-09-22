import 'dart:io';

import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/sellhome.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:image_picker/image_picker.dart';

class BTSSellFinal extends StatefulWidget {
  String name;
  String color;
  String warranty;
  String category;
  String condition;
  String useremail;
  BTSSellFinal(
      {this.name,
      this.color,
      this.warranty,
      this.condition,
      this.category,
      this.useremail});
  @override
  _BTSSellFinalState createState() => _BTSSellFinalState();
}

class _BTSSellFinalState extends State<BTSSellFinal> {
  TextEditingController productInfo = new TextEditingController();
  TextEditingController productPrice = new TextEditingController();
  TextEditingController productDes = new TextEditingController();
  TextEditingController productDis = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  int discount;
  int price;
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
              Text(
                'Seller',
                style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'Times',
                    fontWeight: FontWeight.bold),
              ),
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
              new SizedBox(
                height: 10.0,
                child: new Center(
                  child: new Container(
                    margin:
                        new EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
              productTextField(
                controller: productInfo,
                textTitle: 'Brand/Model',
                textHint: 'Enter product information (Brand/Model)',
              ),
              productTextField(
                controller: productPrice,
                textTitle: 'Price',
                textHint: 'Enter product price',
                textType: TextInputType.number,
              ),
              Divider(thickness: 1.0),
              productTextField(
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
                    height: 1.5,
                    color: Colors.black,
                  ),
                ),
              ),
              productTextField(
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
                    height: 1.5,
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

  requestAdd() async {
    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Image(s) are required!", scaffoldKey);
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
    if (productDes.text == "") {
      showSnackBar('Please add product info', scaffoldKey);
      return;
    }
    if (productPrice.text.contains(" ")) {
      showSnackBar('Please enter valid price', scaffoldKey);
      return;
    }

    Map<String, dynamic> newRequest = {
      pname: widget.name,
      pcolor: widget.color,
      pcondition: widget.condition,
      pwarranty: widget.warranty,
      pcategory: widget.category,
      pinfo: productInfo.text,
      pprice: productPrice.text,
      pdescription: productDes.text,
      purgent: 'No',
      pemail: widget.useremail,
      pdiscount: discount.toString(),
    };
   // displayProgressDialog(context);

    String requestID =
        await appMethod.requestProductAdd(newRequest: newRequest);
    List<String> imagesURL =
        await appMethod.requestImage(imageList: imageList, docID: requestID);
    if (imagesURL.contains(error)) {
      //closeProgressDialog(context);
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
      showSnackBar("An error occured, contact for support", scaffoldKey);
    }

    resetFields();
    showSnackBar('Products added successfully', scaffoldKey);
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new BTSSellHome()));
  }

  List<File> imageList;
  final _picker = ImagePicker();
  PickedFile image;
  pickImage() async {
    image = await _picker.getImage(source: ImageSource.gallery);
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
    productDis.text = "";
    setState(() {});
  }
}
