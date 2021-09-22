import 'package:Sale_App/adminScreens/admin_home.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/forgotpage.dart';
import 'package:Sale_App/userScreens/myHomePage.dart';
import 'package:Sale_App/userScreens/sellInit.dart';
import 'package:Sale_App/userScreens/sellhome.dart';
import 'package:Sale_App/userScreens/signUp.dart';
import 'package:flutter/material.dart';

class BTSLogin extends StatefulWidget {
  @override
  _BTSLoginState createState() => _BTSLoginState();
}

class _BTSLoginState extends State<BTSLogin> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      // appBar: new AppBar(
      //   title: new Text('Login'),
      //   centerTitle: false,
      //   elevation: 0.0,
      // ),r
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
            new SizedBox(height: 80.0),
            //Divider(thickness: 3.0,color: Colors.black,),
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
            Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: InkWell(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: new Text("Forgot password?",
                      style:
                          new TextStyle(color: Colors.white, fontSize: 12.0)),
                ),
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new BTSForgotPass()));
                },
              ),
            ),
            new SizedBox(height: 30.0),
            appButton(
                btnText: "Sign In",
                onBtnClick: verifyLogin,
                btnPadding: 20.0,
                btnColor: Theme.of(context).primaryColor),
            new GestureDetector(
              onTap: () {
                guestlogin();
              },
              child: new Text("Sign In as a Guest",
                  style: new TextStyle(color: Colors.grey, fontSize: 15.0)),
            ),
            SizedBox(
              height: 20.0,
            ),
            new GestureDetector(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (context) => new BTSSignUp()));
              },
              child: new Text("Create New Account",
                  style: new TextStyle(color: Colors.grey, fontSize: 18.0)),
            )
          ],
        ),
      ),
    );
  }

  guestlogin() async {
    displayProgressDialog(context);
    bool response = await appMethods.logOutUser();
    if (response == true) {
      closeProgressDialog(context);
      Navigator.of(context)
          .push(new MaterialPageRoute(builder: (context) => new MyHomePage()));
    }
  }

  verifyLogin() async {
    if (email.text == "") {
      showSnackBar("Email cannot be empty", scaffoldKey);
      return;
    }

    if (password.text == "") {
      showSnackBar("Password cannot be empty", scaffoldKey);
      return;
    }
    //displayProgressDialog(context);
    bool responses = await appMethods.logOutUser();
    String response = await appMethods.loginUser(
        email: email.text.toLowerCase(), password: password.text.toLowerCase());
    String accStatus = await getStringDataLocally(key: userStatus);
    if (response == successful) {
      //closeProgressDialog(context);
      if (accStatus == "Buyer" || accStatus == "Both") {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new MyHomePage()));
      } else if (accStatus == "Seller") {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new BTSSellHome()));
      } else if (accStatus == "Admin") {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new BTSAdminHome()));
      }
      email.text = "";
      password.text = "";
    } else {
      //closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
    }
  }
}
