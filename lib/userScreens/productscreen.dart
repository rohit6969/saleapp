import 'package:Sale_App/tools/app_tools.dart';
import 'package:Sale_App/userScreens/productmodel.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  @override
  final ValueSetter<ProductModel> _valueSetter;
  ProductScreen(this._valueSetter);
  _ProductScreenState createState() => _ProductScreenState();
  List<ProductModel> products = [
    ProductModel("Mic", 50),
    ProductModel("LED Monitor", 100),
    ProductModel("Keyboard", 500),
    ProductModel("Hard drive", 5000),
    ProductModel("Pendrive", 300),
  ];
}

class _ProductScreenState extends State<ProductScreen> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        child: Column(
          children: <Widget>[
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(widget.products[index].name),
                    trailing: Text(
                      "\$${widget.products[index].price}",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      widget._valueSetter(widget.products[index]);
                      showSnackBar("Items added to cart", scaffoldKey);
                    },
                   
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
                itemCount: widget.products.length),
            InkWell(child: Text('Delete'),onTap: (){

            },),
          ],
        ),
      ),
    );
  }
}
