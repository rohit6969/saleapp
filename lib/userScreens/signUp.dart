import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/userScreens/login.dart';
import 'package:flutter/material.dart';

class BTSSignUp extends StatefulWidget {
  @override
  _BTSSignUpState createState() => _BTSSignUpState();
}

class _BTSSignUpState extends State<BTSSignUp> {
  TextEditingController fullname = new TextEditingController();
  TextEditingController status = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController repassword = new TextEditingController();
  TextEditingController phone = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  BuildContext context;
  AppMethods appMethods = new FirebaseMethods();
  bool buyer = false;
  bool seller = false;
  bool news = false;
  String statvalue;

  @override
  Widget build(BuildContext context) {
    // buyer == true && seller == false
    //     ? statvalue = Text('Buyer')
    //     : statvalue = Text('');
    // seller == true && buyer == false
    //     ? statvalue = Text('Seller')
    //     : statvalue = Text('');
    // buyer == true && seller == true
    //     ? statvalue = Text('Both')
    //     : statvalue = Text('');

    this.context = context;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.black,
      // appBar: new AppBar(
      //   title: new Text('Sign Up'),
      //   centerTitle: false,
      //   elevation: 0.0,
      // ),
      body: new SingleChildScrollView(
        child: new Column(
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
            SizedBox(
              height: 20.0,
            ),
            CheckboxListTile(
              title: Text(
                'As a Buyer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              controlAffinity: ListTileControlAffinity.platform,
              value: buyer,
              onChanged: (bool value) {
                setState(() {
                  buyer = value;
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.white,
            ),
            CheckboxListTile(
              title: Text(
                'As a Seller',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              controlAffinity: ListTileControlAffinity.platform,
              value: seller,
              onChanged: (bool value) {
                setState(() {
                  seller = value;
                });
              },
              activeColor: Colors.green,
              checkColor: Colors.white,
            ),
            Center(
              child: CheckboxListTile(
                title: Text(
                  'Receive News on latest products and offers',
                  style: TextStyle(color: Colors.white),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                value: news,
                onChanged: (bool value) {
                  setState(() {
                    news = value;

                    // print(seller);
                  });
                },
                activeColor: Colors.green,
                checkColor: Colors.white,
              ),
            ),
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

  verifyDetails() async {
    if (fullname.text == "") {
      showSnackBar("Full name cannot be empty", scaffoldKey);
      return;
    }
    if (buyer == false && seller == false) {
      showSnackBar('Choose if you are buyer or seller', scaffoldKey);
      return;
    }
    if (buyer == true && seller == false) {
      statvalue = 'Buyer';
      status.text = statvalue;
    }
    if (seller == true && buyer == false) {
      statvalue = 'Seller';
      status.text = statvalue;
    }
    if (seller == true && buyer == true) {
      statvalue = 'Both';
      status.text = statvalue;
    }
    if (statvalue.toString() == "") {
      showSnackBar("Please choose if you're buyer or seller", scaffoldKey);
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
    if (password.text.length<6) {
      showSnackBar("Password must atleast be of 6 characters", scaffoldKey);
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
     if (phone.text.length!=10 ) {
      showSnackBar("Please enter valid phone number of 10 digits", scaffoldKey);
      return;
     }
    if (password.text != repassword.text) {
      showSnackBar("Passwords do not match", scaffoldKey);
      return;
    }
    //displayProgressDialog(context);
    String response = await appMethods.createUserAccount(
        fullname: fullname.text,
        status: status.text,
        email: email.text.toLowerCase(),
        password: password.text.toLowerCase(),
        phone: phone.text,
        state: '',
        street: '',
        city: '',
        country: '');

    if (response == successful) {
      //closeProgressDialog(context);
      Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) => new BTSLogin()));
    } else {
      //closeProgressDialog(context);
      showSnackBar(response, scaffoldKey);
    }
  }
}
