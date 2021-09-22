import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:flutter/material.dart';

class BTSAddAdmin extends StatefulWidget {
  @override
  _BTSAddAdminState createState() => _BTSAddAdminState();
}

class _BTSAddAdminState extends State<BTSAddAdmin> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController fullname = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBars(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 50.0),
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
            new SizedBox(height: 30.0),
            new SizedBox(height: 30.0),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Name",
                textIcon: Icons.person,
                controller: fullname),
            new SizedBox(height: 30.0),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Email Address",
                textIcon: Icons.email,
                controller: email),
            new SizedBox(height: 30.0),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Password",
                textIcon: Icons.lock,
                controller: password),
            new SizedBox(height: 30.0),
            appTextField(
                isPassword: true,
                sidePadding: 18.0,
                textHint: "Re-Password",
                textIcon: Icons.lock,
                controller: repassword),
            new SizedBox(height: 30.0),
            appTextField(
                isPassword: false,
                sidePadding: 18.0,
                textHint: "Phone number",
                textIcon: Icons.phone,
                controller: phone,
                textType: TextInputType.phone),
            appButton(
                btnText: "Sign up",
                onBtnClick: verifyDetails,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
          ],
        ),
      ),
    );
  }

  AppMethods appMethods = new FirebaseMethods();

  verifyDetails() async {
    if (fullname.text == "") {
      showSnackBar("Full name cannot be empty", scaffoldKey);
      return;
    }

    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }
    if (repassword.text == "") {
      showSnackBar("Enter password on both fields", scaffoldKey);
      return;
    }
    if (phone.text == "") {
      showSnackBar("Phone number cannot be empty", scaffoldKey);
      return;
    }
    if (password.text != repassword.text) {
      showSnackBar("Passwords do not match", scaffoldKey);
      return;
    }
   // displayProgressDialog(context);
    String response = await appMethods.createUserAccount(
        fullname: fullname.text,
        status: 'Admin',
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase(),
        phone: phone.text,
        state: '',
        street: '',
        city: '',
        country: '');

    if (response == successful) {
      //closeProgressDialog(context);
      showSnackBar('Admin added successfully', scaffoldKey);
      clearData();
    } else {
      //closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
      clearData();
    }
  }

  clearData() {
    fullname.text = "";
    email.text = "";
    password.text = "";
    phone.text = "";
  }
}
