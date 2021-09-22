import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSViewAd extends StatefulWidget {
  @override
  _BTSViewAdState createState() => _BTSViewAdState();
}

class _BTSViewAdState extends State<BTSViewAd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBars(),
      body: new SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.0,),
            Center(
              
              child: new Text(
                'Added Advertisements',
                style: TextStyle(
                    fontFamily: 'Times',
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            new StreamBuilder(
                stream:
                    Firestore.instance.collection(advertisement).snapshots(),
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
                                Icons.add_box,
                                color: Colors.black45,
                                size: 80.0,
                              ),
                              new Text(
                                "Advertisement",
                                style: new TextStyle(
                                    color: Colors.black45,
                                    fontSize: 20.0,
                                    fontFamily: 'Segoe'),
                              ),
                              new SizedBox(height: 10.0),
                              new Text(
                                "No advertisement exist",
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
                                crossAxisCount: 1, childAspectRatio: 1.75),
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          return buildAd(context, index, document);
                        },
                      );
                    }
                  }
                }),
          ],
        ),
      ),
    );
  }

  Widget buildAd(BuildContext context, int index, DocumentSnapshot document) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20.0,
            ),
            Container(
              height: 170.0,
              width: 170.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('${document[advImages][0]}'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0)),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.0,
                ),
                Text(
                  document[advScreen],
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.0),
                ),
                 SizedBox(
                  height: 10.0,
                ),
                InkWell(
                  onTap: () {
                    deleteData(document.documentID);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  deleteData(var documentID) async {
    bool result;
    await Firestore.instance
        .collection(advertisement)
        .document(documentID)
        .delete()
        .whenComplete(() {
      result = true;
    });
  }
}
