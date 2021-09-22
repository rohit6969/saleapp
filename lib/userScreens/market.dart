import 'package:flutter/material.dart';

class BTSMarket extends StatefulWidget {
  @override
  _BTSMarketState createState() => _BTSMarketState();
}

class _BTSMarketState extends State<BTSMarket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.blueAccent,
        title: new Text('Marketplace'),
      ),
      body: new ListView(
        children: <Widget>[
          new BTSMarkets(
              image:
                  'https://static.bhphoto.com/images/images1000x1000/1536120359_1433711.jpg',
              text: 'Electronics'),
          new BTSMarkets(
              image:
                  'https://cdn.shopify.com/s/files/1/0024/9803/5810/products/405456-Product-0-I_large.jpg',
              text: 'Mobiles'),
          new BTSMarkets(
              image:
                  'https://i.pinimg.com/originals/b9/c8/27/b9c82736a3814b8abf1b8ccda43452df.jpg',
              text: 'Bikes and Cars'),
          new BTSMarkets(
              image:
                  'https://ae01.alicdn.com/kf/H94b846c2475b499b9abfe3e37379a52f6/Makeup-Set-Makeup-Kit-Makeup-Set-Box-Professional-Makeup-Full-Suitcase-Makeup-Set-Matte-Lipstick-Makeup.jpg_960x960.jpg',
              text: 'Fashion'),
          new BTSMarkets(
              image:
                  'https://m.economictimes.com/thumb/height-450,width-600,imgsize-223560,msid-65639345/land-acquisition-getty.jpg',
              text: 'Lands and Buildings'),
          new BTSMarkets(
              image:
                  'https://www.tunturi.org/website/Accessoires/14TUSCF050_3.jpg',
              text: 'Sports and Outdoors'),
          new BTSMarkets(
              image:
                  'https://cdn.mos.cms.futurecdn.net/ahevYTh9pWRzkNPF85MQhb.jpg',
              text: 'Services'),
          new BTSMarkets(
              image:
                  'https://www.cruisefashion.com/images/products/59809401_l.jpg',
              text: 'Others'),
        ],
      ),
    );
  }
}

class BTSMarkets extends StatelessWidget {
  BTSMarkets({this.image, this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.all(20.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            new Image(
              image: NetworkImage(image),
              width: 400,
            ),
            new Text(
              text,
              style: new TextStyle(fontSize: 30.0),
            )
          ],
        ),
      ),
    );
  }
}
