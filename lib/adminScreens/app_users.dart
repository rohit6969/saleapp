import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSAppUsers extends StatefulWidget {
  @override
  _BTSAppUsersState createState() => _BTSAppUsersState();
}

class _BTSAppUsersState extends State<BTSAppUsers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBars(),
        body: new SingleChildScrollView(
          child: Column(
            children: <Widget>[
               SizedBox(
                height: 20.0,
              ),
              Center(
                  child: Text(
                'App Users',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 20.0,
              ),
              new StreamBuilder(
                  stream: Firestore.instance.collection(usersData).snapshots(),
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
                                  Icons.person_add,
                                  color: Colors.black45,
                                  size: 80.0,
                                ),
                                new Text(
                                  "App Users",
                                  style: new TextStyle(
                                      color: Colors.black45,
                                      fontSize: 20.0,
                                      fontFamily: 'Segoe'),
                                ),
                                new SizedBox(height: 10.0),
                                new Text(
                                  "No users exist",
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
                                  crossAxisCount: 1, childAspectRatio: 2),
                          itemCount: dataCount,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot document =
                                snapshot.data.documents[index];
                            return buildSell(context, index, document);
                          },
                        );
                      }
                    }
                  }),
            ],
          ),
        ));
  }

  Widget buildSell(BuildContext context, int index, DocumentSnapshot document) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
        child: Card(
          //elevation: 10.0,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('Users name',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  new Text(
                    '${document[fullName]}',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Segoe'),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('Email',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  new Text(
                    '${document[userEmail]}',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Segoe'),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('Status',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  new Text(
                    '${document[userStatus]}',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Segoe'),
                  ),
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('Phone number',
                      style: TextStyle(
                          fontFamily: 'Segoe',
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0)),
                  new Text(
                    '${document[phoneNumber]}',
                    style: TextStyle(fontSize: 16.0, fontFamily: 'Segoe'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
