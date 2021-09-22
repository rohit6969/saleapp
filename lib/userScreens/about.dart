import 'package:Sale_App/tools/app_tools.dart';
import 'package:flutter/material.dart';

class BTSAbout extends StatefulWidget {
  @override
  _BTSAboutState createState() => _BTSAboutState();
}

class _BTSAboutState extends State<BTSAbout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('About us'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            productText(),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Text(
                'The Name Buy To Sell itself clarifies the statement That "Buy in a sense that you have to sell later". Buy To sell is an online application specially based on buying and  selling products which includes 1st hand(BRANDED PRODUCT) as well 2nd hand(SERVICED PRODUCT) .We from the authority side of Buy To Sell are focused to give efficient results on every deal/transaction made by our customers. We specially work on to be the mediator between the customer choices i.e if the customers wants to Buy the product We become seller as in If the customers wants to Sell the product we become Buyer. So We work on both factor giving services By buying the customers product as well as selling the demanded products.',
                style: new TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
