import 'package:Sale_App/userScreens/itemdetails.dart';
import 'package:Sale_App/userScreens/productDetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'favorites.dart';

//Custom widgets
class BTSOrderCart extends StatelessWidget {
  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 130.0,
              width: 100.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/img/1.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                      offset: Offset(0.0, 5.0)),
                ],
              ),
            ),
            SizedBox(width: 20.0),
            SizedBox(
              width: 20.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    //openDetails();
                  },
                  child: Text(
                    'Dell Laptop',
                    style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  height: 20.0,
                  color: Colors.black,
                ),
                Text(
                  'Rs.' + '20000',
                  style: TextStyle(fontFamily: 'Segoe', color: Colors.grey),
                ),
                SizedBox(height: 10.0),
                Container(
                  //height: 50.0,
                  //width: 100.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  //width: 45.0,
                  //Button column
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.delete,
                            color: Colors.grey,
                          )),
                      Text(
                        '0',
                        style: TextStyle(
                            fontSize: 18.0,
                            //fontFamily: 'Segoe',
                            color: Colors.grey),
                      ),
                      InkWell(
                          onTap: () {},
                          child: Icon(
                            Icons.add,
                            color: Colors.grey,
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
              ],
            ),
            Spacer(),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  Icons.cancel,
                  color: Colors.grey,
                )),
          ],
        ),
      ),
    );
  }

  void openDetails() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new HomePage()));
  }
}
