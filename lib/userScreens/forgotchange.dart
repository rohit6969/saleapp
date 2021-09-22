import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BTSForgetChange extends StatefulWidget {
  String id;
  BTSForgetChange(this.id);
  @override
  _BTSForgetChangeState createState() => _BTSForgetChangeState();
}

class _BTSForgetChangeState extends State<BTSForgetChange> {
  @override
  TextEditingController userpass = new TextEditingController();
  TextEditingController repass = new TextEditingController();
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
              'Please enter your new password',
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            new SizedBox(height: 30.0),
            //Divider(thickness: 3.0,color: Colors.black,),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Enter your new password",
                textIcon: Icons.lock,
                controller: userpass),
            new SizedBox(height: 50.0),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Re-enter your password",
                textIcon: Icons.lock,
                controller: repass),
            new SizedBox(height: 50.0),
            appButton(
                btnText: "Continue",
                onBtnClick: () {
                  verifypassword(context);
                },
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        )));
  }

  verifypassword(BuildContext context) async {
    if (userpass.text == '') {
      showSnackBar('Please enter your password', scaffoldKey);
      return;
    }
    if (repass.text == '') {
      showSnackBar('Please enter your password', scaffoldKey);
      return;
    }
    if (userpass.text != repass.text) {
      showSnackBar('Passwords do not match!', scaffoldKey);
      return;
    }
    displayProgressDialog(context);
    showSnackBar('Please contact the administrator!', scaffoldKey);
    closeProgressDialog(context);
    resetFields();

    // bool result;
    // await Firestore.instance
    //     .collection(usersData)
    //     .document(widget.id)
    //     .updateData({userPassword: userpass.text}).whenComplete(() {
    //   result = true;
    // });
    // showSnackBar('Password updated successfully', scaffoldKey);
  }

  resetFields() {
    userpass.text = "";
    repass.text = "";
  }
}
