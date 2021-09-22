import 'package:Sale_App/userScreens/productmodel.dart';
import 'package:Sale_App/userScreens/productscart.dart';
import 'package:Sale_App/userScreens/productscreen.dart';
import 'package:flutter/material.dart';

class ProductCartHome extends StatefulWidget {
  @override
  _ProductCartHomeState createState() => _ProductCartHomeState();
}

class _ProductCartHomeState extends State<ProductCartHome> {
  List<ProductModel> cart = [];
  int sum = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Cart App"),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: "Products"),
              Tab(text: "Checkout"),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          ProductScreen((selectedProduct) {
            setState(() {
              cart.add(selectedProduct);
              sum = 0;
              cart.forEach((item) {
                sum = sum + item.price;
              });
            });
          }),
          ProductCart(cart, sum),
        ]),
      ),
    );
  }
}
