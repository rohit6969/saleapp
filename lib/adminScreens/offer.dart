import 'dart:io';

import 'package:Sale_App/adminScreens/viewoffer.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BTSOffer extends StatefulWidget {
  @override
  _BTSOfferState createState() => _BTSOfferState();
}

class _BTSOfferState extends State<BTSOffer> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            new SizedBox(height: 30.0),
            Text(
              'Offers',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new BTSViewOffer()));
                },
                child: Text(
                  'View added offers',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[700]),
                )),
            SizedBox(
              height: 20.0,
            ),
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
                    label: new Text("Add Offer",
                        style: new TextStyle(color: Colors.white))),
              ),
            ),
            MultiImagePickerList(
                imageList: imageList,
                removeNewImage: (index) {
                  removeImage(index);
                }),
            new SizedBox(height: 10.0),
            new SizedBox(height: 30.0),
            appButton(
                btnText: "Add Offer",
                onBtnClick: addNewAd,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  removeImage(int index) async {
    imageList.removeAt(index);
    setState(() {});
  }

  AppMethods appMethod = new FirebaseMethods();
  String date = DateTime.now().toString();
  List<File> imageList;
  pickImage() async {
    File file = (await ImagePicker.pickImage(source: ImageSource.gallery));
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

  addNewAd() async {
    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Image(s) are required!", scaffoldKey);
      return;
    }

//    displayProgressDialog(context);

    Map<String, dynamic> newProduct = {offerDate: date};
    String adID = await appMethod.addNewOffer(newProduct: newProduct);
    List<String> imagesURL =
        await appMethod.offerImageUpload(docID: adID, imageList: imageList);
    if (imagesURL.contains(error)) {
      closeProgressDialog(context);
      showSnackBar("Image upload Error, contact for support", scaffoldKey);
      return;
    }
    bool result =
        await appMethod.updateOfferImages(docID: adID, data: imagesURL);
    if (result != null && result == true) {
      //closeProgressDialog(context);
      resetEverything();
      showSnackBar("Offer added successfully", scaffoldKey);
    } else {
      //closeProgressDialog(context);
      showSnackBar("An error occured, contact for support", scaffoldKey);
    }
  }

  resetEverything() {
    imageList.clear();
    setState(() {});
  }
}
