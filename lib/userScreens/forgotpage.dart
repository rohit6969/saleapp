import 'dart:async';

import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/forgotchange.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BTSForgotPass extends StatefulWidget {
  @override
  _BTSForgotPassState createState() => _BTSForgotPassState();
}

class _BTSForgotPassState extends State<BTSForgotPass> {
  TextEditingController useremail = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.black,
        body: new SingleChildScrollView(
            child: new Column(
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Buy  ',
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.lightBlueAccent,
                      fontFamily: 'Toxia',
                      fontWeight: FontWeight.bold),
                ),
                Text('To  ',
                    style: TextStyle(
                        fontFamily: 'Toxia',
                        fontSize: 50.0,
                        color: Colors.red[800],
                        fontWeight: FontWeight.bold)),
                Text('Sell',
                    style: TextStyle(
                        fontFamily: 'Toxia',
                        fontSize: 50.0,
                        color: Colors.lightBlueAccent,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            new SizedBox(height: 100.0),
            Text(
              'Please enter your email',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            new SizedBox(height: 30.0),
            //Divider(thickness: 3.0,color: Colors.black,),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textType: TextInputType.emailAddress,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: useremail),
            new SizedBox(height: 50.0),
            appButton(
                btnText: "Continue",
                onBtnClick: () {
                  checkuser(context);
                },
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        )));
  }

  checkuser(BuildContext context) async {
    if (useremail.text == '') {
      showSnackBar('Please enter your email address', scaffoldKey);
      return;
    }
    displayProgressDialog(context);

    var documents = await Firestore.instance
        .collection(usersData)
        .where(userEmail, isEqualTo: useremail.text)
        .getDocuments()
        .then((event) async {
      if (event.documents.isNotEmpty) {
        print('Password email sent');
        await sendPasswordResetEmail(useremail.text);

        showSnackBar(
            'Password reset link has been sent to your email', scaffoldKey);
        closeProgressDialog(context);
        useremail.text="";
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new BTSLogin()));
        });

        // Map<String, dynamic> documentData =
        //     event.documents.single.data; //if it is a single document

        // Navigator.of(context).push(new MaterialPageRoute(
        //     builder: (BuildContext context) =>
        //         new BTSForgetChange(documentData[userID])));
      } else {
        showSnackBar('Invalid user!', scaffoldKey);
      }
    }).catchError((e) => showSnackBar("Error fetching data: $e", scaffoldKey));
  }

  Future sendPasswordResetEmail(String email) async {
    return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
