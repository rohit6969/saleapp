import 'dart:io';
import 'package:Sale_App/tools/progressdialog.dart';
import 'package:Sale_App/userScreens/cart.dart';
import 'package:Sale_App/userScreens/sellerhistory.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Sale_App/tools/app_data.dart';

Widget appTextField(
    {IconData textIcon,
    String textHint,
    bool isPassword,
    double sidePadding,
    TextInputType textType,
    TextEditingController controller}) {
  sidePadding == null ? sidePadding = 0.0 : sidePadding;
  textHint == null ? textHint = "" : textHint;
  //textType == null ? textType == TextInputType.text : textType;
  return Padding(
    padding: new EdgeInsets.only(left: sidePadding, right: sidePadding),
    child: new Container(
        decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          border: new Border.all(color: Colors.black),
        ),
        child: new TextField(
          controller: controller,
          obscureText: isPassword == null ? false : isPassword,
          keyboardType: textType == null ? TextInputType.text : textType,
          decoration: new InputDecoration(
              border: InputBorder.none,
              hintText: textHint,
              prefixIcon:
                  textIcon == null ? new Container() : new Icon(textIcon)),
        )),
  );
}

Widget MultiImagePickerList(
    {List<File> imageList, VoidCallback removeNewImage(int position)}) {
  return new Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
    child: imageList == null || imageList.length == 0
        ? new Container()
        : new SizedBox(
            height: 150.0,
            child: new ListView.builder(
                itemCount: imageList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return new Padding(
                    padding: new EdgeInsets.only(left: 3.0, right: 3.0),
                    child: new Stack(
                      children: <Widget>[
                        new Container(
                          width: 150.0,
                          height: 150.0,
                          decoration: new BoxDecoration(
                              color: Colors.grey.withAlpha(100),
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(15.0)),
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new FileImage(imageList[index]))),
                        ),
                        new Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: new CircleAvatar(
                            backgroundColor: Colors.red[600],
                            child: new IconButton(
                                icon: new Icon(
                                  Icons.clear,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  removeNewImage(index);
                                }),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
  );
}

Widget appButton(
    {String btnText,
    double btnPadding,
    Color btnColor,
    VoidCallback onBtnClick}) {
  btnText == null ? btnText = "App Button" : btnText;
  btnPadding == null ? btnPadding = 0.0 : btnPadding;
  btnColor == null ? btnColor = Colors.black : btnColor;

  return Padding(
    padding: new EdgeInsets.all(btnPadding),
    child: new RaisedButton(
      color: Colors.white,
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
      ),
      onPressed: onBtnClick,
      child: Container(
        height: 50.0,
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: new Text(
            btnText,
            style: new TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ),
      ),
    ),
  );
}

Widget productTextField(
    {String textTitle,
    String textHint,
    double height,
    TextEditingController controller,
    TextInputType textType,
    int maxLines}) {
  textTitle == null ? textTitle = "Enter title" : textTitle;
  textHint == null ? textHint = "Enter hint" : textHint;
  height == null ? height = 50.0 : height;
  //height!=null ?

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          textTitle,
          style: new TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Container(
          height: height,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.black),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new TextField(
              controller: controller,
              keyboardType: textType == null ? TextInputType.text : textType,
              maxLines: maxLines == null ? null : maxLines,
              decoration: new InputDecoration(
                  border: InputBorder.none, hintText: textHint),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget urgentText(
    {String textTitle,
    String textHint,
    double height,
    TextEditingController controller,
    TextInputType textType,
    int maxLines}) {
  textTitle == null ? textTitle = "Enter title" : textTitle;
  textHint == null ? textHint = "Enter hint" : textHint;
  height == null ? height = 50.0 : height;
  //height!=null ?

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          textTitle,
          style: new TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
      ),
      new Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: new Container(
          height: height,
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.red[900]),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: new Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new TextField(
              controller: controller,
              keyboardType: textType == null ? TextInputType.text : textType,
              maxLines: maxLines == null ? null : maxLines,
              decoration: new InputDecoration(
                  border: InputBorder.none, hintText: textHint),
            ),
          ),
        ),
      ),
    ],
  );
}

appData() {
  final userRef = Firestore.instance.collection('appProducts');
  userRef.getDocuments().then((snapshot) {
    snapshot.documents.forEach((doc) {
      print(doc.data['productTitle']);
    });
  });
}

class DataSearch extends SearchDelegate<String> {
  final cities = [
    'Kathmandu',
    'Bhaktapur',
    'Lalitpur',
    'Pokhara',
    'Chitwan',
    'Butwal',
    'Bhairahawa',
    'Dang',
    'Jhapa',
    'Dharan',
    'Surkhet',
    'Nepalgunj',
    'Biratnagar',
    'Birgunj'
  ];
  final recentCities = [
    'Kathmandu',
    'Bhaktapur',
    'Lalitpur',
    'Pokhara',
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on the selection
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        child: Card(
          color: Colors.red,
          //shape: StadiumBorder(),
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    //what users types is query
    final suggestionList = query.isEmpty
        ? recentCities
        : cities.where((p) => p.startsWith(query)).toList();

    //recent suggestion list
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          showResults(context);
        },
        leading: Icon(Icons.location_city),
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: suggestionList[index].substring(query.length),
                    style: TextStyle(color: Colors.grey)),
              ]),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}

Widget noDataFound() {
  return new Container(
    child: new Center(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            Icons.find_in_page,
            color: Colors.black45,
            size: 80.0,
          ),
          new Text(
            "Product not available yet",
            style: new TextStyle(color: Colors.black45, fontSize: 20.0),
          ),
          new SizedBox(height: 10.0),
          new Text(
            "Please check back later",
            style: new TextStyle(color: Colors.red, fontSize: 14.0),
          ),
        ],
      ),
    ),
  );
}

Widget appBars() {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Buy  ',
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.lightBlueAccent,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Toxia'),
        ),
        Text('To  ',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.red[800],
                //fontWeight: FontWeight.bold,
                fontFamily: 'Toxia')),
        Text('Sell',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Toxia')),
      ],
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}

Widget sellBars(BuildContext context) {
  return AppBar(
    iconTheme: IconThemeData(
      color: Colors.black, //change your color here
    ),
    title: Row(
      mainAxisSize: MainAxisSize.min,
      //mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          'Buy  ',
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.lightBlueAccent,
              //fontWeight: FontWeight.bold,
              fontFamily: 'Toxia'),
        ),
        Text('To  ',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.red[800],
                //fontWeight: FontWeight.bold,
                fontFamily: 'Toxia')),
        Text('Sell',
            style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
                //fontWeight: FontWeight.bold,
                fontFamily: 'Toxia')),
      ],
    ),
    centerTitle: true,
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    actions: <Widget>[
      new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new IconButton(
              icon: new Icon(Icons.monetization_on),
              onPressed: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSSellHistory()));
              }),
        ],
      )
    ],
  );
}

Widget productText() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    //crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text(
        'Buy  ',
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.lightBlueAccent,
            fontWeight: FontWeight.bold,
            fontFamily: 'Toxia'),
      ),
      Text('To  ',
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.red[800],
              fontWeight: FontWeight.bold,
              fontFamily: 'Toxia')),
      Text('Sell',
          style: TextStyle(
              fontSize: 30.0,
              color: Colors.lightBlueAccent,
              fontWeight: FontWeight.bold,
              fontFamily: 'Toxia')),
    ],
  );
}

Widget productDropDown(
    {String textTitle,
    String selectedItem,
    List<DropdownMenuItem<String>> dropDownItems,
    ValueChanged<String> changedDropdownItems}) {
  textTitle == null ? textTitle = "Enter title" : textTitle;
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Text(
          textTitle,
          style: new TextStyle(fontWeight: FontWeight.w700, color: Colors.grey),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Container(
          decoration: new BoxDecoration(
              color: Colors.white,
              border: new Border.all(color: Colors.black),
              borderRadius: new BorderRadius.all(new Radius.circular(4.0))),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: new DropdownButtonHideUnderline(
                child: new DropdownButton(
                    value: selectedItem,
                    items: dropDownItems,
                    onChanged: changedDropdownItems)),
          ),
        ),
      ),
    ],
  );
}

List<DropdownMenuItem<String>> buildAndGetDropDownItems(List size) {
  List<DropdownMenuItem<String>> items = new List();
  for (String size in size) {
    items.add(new DropdownMenuItem(value: size, child: new Text(size)));
  }
  return items;
}

showSnackBar(String message, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(new SnackBar(
    backgroundColor: Colors.red[600],
    content: new Text(
      message,
      style: new TextStyle(color: Colors.white),
    ),
  ));
}

displayProgressDialog(BuildContext context) {
  Navigator.of(context)
      .push(new PageRouteBuilder(pageBuilder: (BuildContext context, _, __) {
    return new ProgressDialog();
  }));
}

closeProgressDialog(BuildContext context) {
  Navigator.of(context).pop();
}

writeDataLocally({String key, String value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setString(key, value);
}

writeBoolLocally({String key, bool value}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.setBool(key, value);
}

getDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.get(key);
}

getStringDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.getString(key);
}

getBoolDataLocally({String key}) async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  return localData.getBool(key) == null ? false : localData.getBool(key);
}

clearDataLocally() async {
  Future<SharedPreferences> saveLocal = SharedPreferences.getInstance();
  final SharedPreferences localData = await saveLocal;
  localData.clear();
}
