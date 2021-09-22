import 'package:Sale_App/tools/searchClass.dart';
import 'package:Sale_App/userScreens/messages.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_state.dart';
import 'package:flutter/material.dart';

class BTSDash extends StatefulWidget {
  @override
  _BTSDashState createState() => _BTSDashState();
}

class _BTSDashState extends State<BTSDash> {
  @override
   Widget build(BuildContext context) {
  return Scaffold(
      appBar: AppBar(title: Text('mypage'),),
      body: CarouselSlider(
        options: CarouselOptions(
        autoPlay: true),
        items: [
          'lib/img/1.jpg',
          'lib/img/2.jpg',
          'lib/img/3.jpg',
          'lib/img/4.jpg',
          'lib/img/5.jpg',
        ].map((i){
          return Builder(
            builder:(BuildContext context){
             return Container(

                width: MediaQuery.of(context).size.width,
               child: GestureDetector(
                child:Stack(
                  children: <Widget>[
                    Image.asset(i,fit: BoxFit.fill,),
                    
                  ],
                ),
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => BTSMessages()),
                   );
                 },
               ),
              );
            }
          );
        }).toList()
      ),
    );
  }
}
