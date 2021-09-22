import 'dart:io';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:flutter/material.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:image_picker/image_picker.dart';

class BTSAddProducts extends StatefulWidget {
  @override
  _BTSAddProductsState createState() => _BTSAddProductsState();
}

class _BTSAddProductsState extends State<BTSAddProducts> {
  List<DropdownMenuItem<String>> dropDownColors;
  String selectedColor;
  int discount;
  List<String> colorList = new List();

  List<DropdownMenuItem<String>> dropDownSizes;
  String selectedSize;

  List<DropdownMenuItem<String>> dropDownCategory;
  String selectedCategory;
  List<String> categoryList = new List();
  String imageUrl;

  List<String> sizeList = new List();

  Map<int, File> imagesMap = new Map();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController productTitleController = new TextEditingController();
  TextEditingController productPriceController = new TextEditingController();
  TextEditingController productDesController = new TextEditingController();
  TextEditingController productDisController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    colorList = new List.from(localColors);
    sizeList = new List.from(localSizes);
    categoryList = new List.from(localCategories);
    dropDownColors = buildAndGetDropDownItems(colorList);
    dropDownSizes = buildAndGetDropDownItems(sizeList);
    dropDownCategory = buildAndGetDropDownItems(categoryList);
    selectedColor = dropDownColors[0].value;
    selectedSize = dropDownSizes[0].value;
    selectedCategory = dropDownCategory[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      //backgroundColor: Colors.transparent,
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new SizedBox(height: 10.0),
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
                textTitle: "Product Title",
                textHint: "Enter Product Title",
                controller: productTitleController),
            Divider(
              thickness: 1.0,
              height: 30.0,
              color: Colors.black,
            ),
            productTextField(
                textTitle: "Product Price",
                textHint: "Enter Product Price",
                textType: TextInputType.number,
                controller: productPriceController),
            new SizedBox(height: 10.0),
            productTextField(
                textTitle: "Product Discount",
                textHint: "Enter Product Discount",
                textType: TextInputType.number,
                controller: productDisController),
            Divider(
              thickness: 1.0,
              height: 30.0,
              color: Colors.black,
            ),
            productTextField(
                textTitle: "Product Description",
                textHint: "Enter Description",
                controller: productDesController,
                maxLines: 6,
                height: 180.0),
            SizedBox(
              height: 10.0,
            ),
            productDropDown(
                textTitle: "Product Categories",
                selectedItem: selectedCategory,
                dropDownItems: dropDownCategory,
                changedDropdownItems: changedDropDownCategory),
            Divider(
              thickness: 1.0,
              height: 30.0,
              color: Colors.black,
            ),
            appButton(
                btnText: "Add Product",
                onBtnClick: addNewProducts,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  void changedDropDownColor(String selectedSize) {
    setState(() {
      selectedColor = selectedSize;
      print(selectedSize);
    });
  }

  void changedDropDownCategory(String selectedSize) {
    setState(() {
      selectedCategory = selectedSize;
      print(selectedSize);
    });
  }

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

  removeImage(int index) async {
    imageList.removeAt(index);
    setState(() {});
  }

  AppMethods appMethod = new FirebaseMethods();

  void changedDropDownSize(String selectedSizes) {
    setState(() {
      selectedSize = selectedSizes;
      //print(selectedSizes);
    });
  }

  int price;

  addNewProducts() async {
    if (imageList == null || imageList.isEmpty) {
      showSnackBar("Image(s) are required!", scaffoldKey);
      return;
    }
    if (productTitleController.text == "") {
      showSnackBar("Product Title be empty", scaffoldKey);
      return;
    }
    if (productPriceController.text == "") {
      showSnackBar("Product Price be empty", scaffoldKey);
      return;
    }
    String tempDis;
    if (productDisController.text == "") {
      tempDis = "0";
      discount = int.parse(tempDis);
    } else {
      discount = int.parse(productDisController.text);
      price = int.parse(productPriceController.text);
      if (discount < 0 || discount >= price) {
        showSnackBar('Please enter valid discount', scaffoldKey);
        return;
      }
    }
    if (productDesController.text == "") {
      showSnackBar("Product Description be empty", scaffoldKey);
      return;
    }
    if (selectedCategory == "Select product category") {
      showSnackBar("Please select a category", scaffoldKey);
      return;
    }

    //show progress dialog
   // displayProgressDialog(context);

    //Get the text from the inidividual controllers title,price, description
    Map<String, dynamic> newProduct = {
      productTitle: productTitleController.text,
      productPrice: productPriceController.text,
      productDesc: productDesController.text,
      productDate:date,
      productDiscount: discount.toString(),
      productCategory: selectedCategory,
      searchKey: productTitleController.text.substring(0, 1),
    };
    //Adding the information to firebase
    String productID = await appMethod.addNewProduct(newProduct: newProduct);

    //Upload images to firebase storage
    List<String> imagesURL = await appMethod.uploadProductImages(
        docID: productID, imageList: imageList);

    //if error occured terminate here
    if (imagesURL.contains(error)) {
      //closeProgressDialog(context);
      showSnackBar("Image upload Error, contact for support", scaffoldKey);
      return;
    }
    //Update information after image upload
    bool result =
        await appMethod.updateProductImages(docID: productID, data: imagesURL);

    if (result != null && result == true) {
      //closeProgressDialog(context);
      resetEverything();
      showSnackBar("An error occured, contact for support", scaffoldKey);
    } else {
      //closeProgressDialog(context);
      showSnackBar("An error occured, contact for support", scaffoldKey);
    }
  }

  void resetEverything() {
    imageList.clear();
    productTitleController.text = "";
    productPriceController.text = "";
    productDesController.text = "";
    productDisController.text = "";
    selectedCategory = "Select product category";
    selectedColor = "Select a color";
    selectedSize = "Select a size";
    setState(() {});
  }

  Map newProduct = {};
}
