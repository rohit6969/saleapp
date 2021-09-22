import 'package:Sale_App/userScreens/productmodel.dart';
import 'package:Sale_App/userScreens/productscreen.dart';
import 'package:flutter/material.dart';
import 'productcarthome.dart';

class ProductCart extends StatefulWidget {
  //ProductScreen(this._valueSetter);
  final cart;
  var sum;
  ProductCart(this.cart, this.sum);
  @override
  _ProductCartState createState() => _ProductCartState();
}

class _ProductCartState extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(widget.cart[index].name),
                trailing: Column(
                  children: <Widget>[
                    InkWell(
                      child: Text(
                        'Delete',
                      ),
                      onTap: () {
                        setState(() {
                          widget.cart.removeAt(index);
                          
                        });
                      },
                    ),
                    Text(
                      "\$${widget.cart[index].price}",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                onTap: () {},
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: widget.cart.length),
        Divider(),
        Text("Total: " + "\$${widget.sum}")
      ],
      //body: ,
    );
  }
}
