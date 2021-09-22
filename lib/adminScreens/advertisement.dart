import 'dart:io';

import 'package:Sale_App/adminScreens/viewad.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BTSAdvertisement extends StatefulWidget {
  @override
  _BTSAdvertisementState createState() => _BTSAdvertisementState();
}

class _BTSAdvertisementState extends State<BTSAdvertisement> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List<DropdownMenuItem<String>> dropDownScreens;
  List<String> screenList = new List();
  String selectedScreen;
  TextEditingController adLink = new TextEditingController();

  @override
  void initState() {
    super.initState();
    screenList = new List.from(localScreen);
    dropDownScreens = buildAndGetDropDownItems(screenList);
    selectedScreen = dropDownScreens[0].value;
  }

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
              'Advertisement',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            InkWell(
                onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new BTSViewAd()));
                },
                child: Text(
                  'View advertisements',
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
                    label: new Text("Add Advert",
                        style: new TextStyle(color: Colors.white))),
              ),
            ),
            MultiImagePickerList(
                imageList: imageList,
                removeNewImage: (index) {
                  removeImage(index);
                }),
            new SizedBox(height: 10.0),
            productTextField(
                textTitle: "Advertisement link",
                textHint: "Enter advertisement link here",
                controller: adLink),
            productDropDown(
                textTitle: "Display Screen",
                selectedItem: selectedScreen,
                dropDownItems: dropDownScreens,
                changedDropdownItems: changedDropDownScreen),
            new SizedBox(height: 30.0),
            appButton(
                btnText: "Add Advertisement",
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
  void changedDropDownScreen(String selectedSizes) {
    setState(() {
      selectedScreen = selectedSizes;
      //print(selectedSizes);
    });
  }

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
    if (adLink.text == "") {
      showSnackBar("Please add advertisement redirect link!", scaffoldKey);
      return;
    }
   // displayProgressDialog(context);

    Map<String, dynamic> newProduct = {
      advLink: adLink.text,
      advScreen: selectedScreen,
    };
    String adID = await appMethod.addNewAd(newProduct: newProduct);
    List<String> imagesURL =
        await appMethod.adImageUpload(docID: adID, imageList: imageList);
    if (imagesURL.contains(error)) {
      closeProgressDialog(context);
      showSnackBar("Image upload Error, contact for support", scaffoldKey);
      return;
    }
    bool result = await appMethod.updateAdImages(docID: adID, data: imagesURL);
    if (result != null && result == true) {
      //closeProgressDialog(context);
      resetEverything();
      showSnackBar("Advertisement added successfully", scaffoldKey);
    } else {
      //closeProgressDialog(context);
      showSnackBar("An error occured, contact for support", scaffoldKey);
    }
  }

  resetEverything() {
    adLink.text = "";
    imageList.clear();
    setState(() {});
  }
}
