import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/searchClass.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BTSAdminSearch extends StatefulWidget {
  @override
  _BTSAdminSearchState createState() => _BTSAdminSearchState();
}

var lists = [];

class _BTSAdminSearchState extends State<BTSAdminSearch> {
  var queryResultSet = [];
  var tempSearchStore = [];
  BuildContext context;

  initiateSearch(value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }

    // var capitalizedValue =
    //     value.substring(0, 1).toUpperCase() + value.substring(1);

    if (queryResultSet.length == 0 && value.length == 1) {
      BTSSearch().searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          setState(() {
            tempSearchStore.add(queryResultSet[i]);
          });
        }
      });
    } else {
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element[productTitle].toLowerCase().contains(value.toLowerCase()) ==
            true) {
          if (element[productTitle]
                  .toLowerCase()
                  .indexOf(value.toLowerCase()) ==
              0) {
            setState(() {
              tempSearchStore.add(element);
            });
          }
        }
      });
    }
    if (tempSearchStore.length == 0 && value.length > 1) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        // appBar: appBars(),
        body: ListView(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: (val) {
            initiateSearch(val);
          },
          decoration: InputDecoration(
              prefixIcon: IconButton(
                color: Colors.black,
                icon: Icon(Icons.arrow_back),
                iconSize: 20.0,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              contentPadding: EdgeInsets.only(left: 25.0),
              hintText: 'Search by name',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(4.0))),
        ),
      ),
      SizedBox(height: 10.0),
      GridView.count(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          crossAxisCount: 2,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
          primary: false,
          shrinkWrap: true,
          children: tempSearchStore.map((element) {
            return InkWell(onTap: () {}, child: buildResultCard(element));
          }).toList())
    ]));
  }
}

Widget buildResultCard(data) {
  return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //elevation: 2.0,
      child: Container(
          child: Center(
              child: Text(
        data[productTitle],
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
      ))));
}
