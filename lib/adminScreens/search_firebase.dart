import 'package:Sale_App/tools/app_tools.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Sale_App/tools/app_data.dart';

class BTSSearchFirebase extends StatefulWidget {
  @override
  _BTSSearchFirebaseState createState() => _BTSSearchFirebaseState();
}

Firestore firestore = Firestore.instance;
String query = "";
List<String> newList = new List();
final fb = FirebaseDatabase.instance.reference().child("productTitle");

class _BTSSearchFirebaseState extends State<BTSSearchFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List view design'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String selected = await showSearch(
                  context: context, delegate: _MySearchDelegate());
              if (selected != null && selected != query) {
                setState(() {
                  query = selected;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  // void initState() {
  //   fb.once().then((DataSnapshot snap) {
  //     print(snap);
  //     var data = snap.value;
  //     print(data);
  //     newList.clear();
  //     data.forEach((key, value) {
  //       DataSearch model = new DataSearch(
  //         list: value['pname'],
  //       );
  //       newlist.add(value['topic']);
  //       newList.add(model);
  //     });
  //   });
  // }
}

class _MySearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
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
    return Text(query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    throw UnimplementedError();
  }
}
