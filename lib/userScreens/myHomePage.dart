
import 'package:Sale_App/adminScreens/order_history.dart';
import 'package:Sale_App/adminScreens/search_data.dart';
import 'package:Sale_App/adminScreens/showclick.dart';
import 'package:Sale_App/tools/app_data.dart';
import 'package:Sale_App/tools/appmethods.dart';
import 'package:Sale_App/tools/firebase_methods.dart';
import 'package:Sale_App/tools/store.dart';
import 'package:Sale_App/userScreens/contactus.dart';
import 'package:Sale_App/userScreens/itemdetails.dart';
import 'package:Sale_App/userScreens/lol.dart';
import 'package:Sale_App/userScreens/sellcat.dart';
import 'package:Sale_App/userScreens/showProducts.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about.dart';
import 'cart.dart';
import 'profile.dart';
import 'login.dart';
import 'package:Sale_App/tools/app_tools.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  String accName = "";
  String accEmail = "";
  String accStatus = "";
  String accPhotoURL = "";
  String accID = "";
  bool accIsLoggedIn;
  AppMethods appMethods = new FirebaseMethods();
  Firestore firestore = Firestore.instance;
  String usersStatus;
  String cartnumber = '';

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    totalLikes();
  }

  Future totalLikes() async {
    var respectsQuery = Firestore.instance.collection(userCart);
    var querySnapshot = await respectsQuery.getDocuments();
    var totalEquals = querySnapshot.documents.length;
    cartnumber = totalEquals.toString();
  }

  Future getCurrentUser() async {
    //DocumentSnapshot userInfo= await appMethods.getUserInfo(user.uid);
    accName = await getStringDataLocally(key: fullName);
    accEmail = await getStringDataLocally(key: userEmail);
    accPhotoURL = await getStringDataLocally(key: photoURL);
    accIsLoggedIn = await getBoolDataLocally(key: loggedIn);
    accStatus = await getStringDataLocally(key: userStatus);
    accID = await getStringDataLocally(key: userID);

    //accStatus == 'Seller' || accStatus=='Both' ? usersStatus = 'Sell' : usersStatus = 'Buy';

    accStatus == null || accStatus == 'Buyer'
        ? usersStatus = 'Buy'
        : usersStatus = 'Sell';
    accName == null ? accName = "Guest User" : accName;
    accEmail == null ? accEmail = "guestuser@email.com" : accEmail;

    setState(() {});
  }

  BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;

    Widget image_slider_carousel = Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Carousel(
          boxFit: BoxFit.fill,
          images: [
            AssetImage('lib/img/1.jpg'),
            AssetImage('lib/img/2.jpg'),
            AssetImage('lib/img/3.jpg'),
            AssetImage('lib/img/4.jpg'),
            AssetImage('lib/img/5.jpg'),
          ],
          autoplay: true,
          indicatorBgPadding: 1.0,
          dotColor: Colors.transparent,
          dotSize: 4.0,
        ),
      ),
    );
    Widget carousel_slider = new Container(
      height: 200.0,
      child: CarouselSlider(
          options: CarouselOptions(autoPlay: true),
          items: [
            'lib/img/1.jpg',
            'lib/img/2.jpg',
            'lib/img/3.jpg',
            'lib/img/4.jpg',
            'lib/img/5.jpg',
          ].map((i) {
            return Builder(builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        i,
                        fit: BoxFit.fill,
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BTSShowProducts()),
                    );
                  },
                ),
              );
            });
          }).toList()),
    );
    return Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: Colors.black),
        title: GestureDetector(
          // onLongPress: openAdmin,
          child: productText(),
        ),
        centerTitle: true,
        actions: <Widget>[
          new Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              new IconButton(
                  icon: new Icon(Icons.add_shopping_cart, color: Colors.black),
                  onPressed: () {
                    if (accIsLoggedIn == true) {
                      Navigator.of(context).push(new CupertinoPageRoute(
                          builder: (BuildContext context) => new BTSCart()));
                    } else {
                      showSnackBar(
                          'Login required to access cart', scaffoldKey);
                    }
                  }),
              new CircleAvatar(
                radius: 8.0,
                backgroundColor: Colors.red,
                child: new StreamBuilder(
                    stream: Firestore.instance
                        .collection(userCart)
                        .where(cartEmail, isEqualTo: accEmail)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        //return buildShimmer();
                        return new Center(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor)));
                      } else {
                        final int dataCount = snapshot.data.documents.length;
                        return (Text('$dataCount',
                            style: new TextStyle(
                                color: Colors.white, fontSize: 11.0)));
                      }
                    }),
              )
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    if (accIsLoggedIn == true) {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              new BTSSearchData()));
                    } else {
                      showSnackBar(
                          'Login required to search data', scaffoldKey);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            new StreamBuilder(
                stream: Firestore.instance
                    .collection(offer)
                    .orderBy(offerDate, descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //return buildShimmer();
                    return new Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)));
                  } else {
                    final int dataCount = snapshot.data.documents.length;
                    //print("data count $dataCount");
                    if (dataCount == 0) {
                      return new Container(
                        height: 0.0,
                        width: 0.0,
                      );
                    } else {
                      return new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          return buildOffer(context, index, document);
                        },
                      );
                    }
                  }
                }),

            // Text(
            //   'Popular products',
            //   style: TextStyle(
            //       fontSize: 20.0,
            //       fontFamily: 'Times',
            //       fontWeight: FontWeight.bold),
            // ),
            // SizedBox(
            //   height: 10.0,
            // ),
            // carousel_slider,
            // SizedBox(
            //   height: 20.0,
            // ),

            SizedBox(
              height: 20.0,
            ),
            new StreamBuilder(
                stream: Firestore.instance
                    .collection(advertisement)
                    .where(advScreen, isEqualTo: 'Home Page')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //return buildShimmer();
                    return new Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)));
                  } else {
                    final int dataCount = snapshot.data.documents.length;
                    //print("data count $dataCount");
                    if (dataCount == 0) {
                      return new Container(
                        height: 0.0,
                        width: 0.0,
                      );
                    } else {
                      return new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          return buildAd(context, index, document);
                        },
                      );
                    }
                  }
                }),
            SizedBox(
              height: 40.0,
            ),
            new StreamBuilder(
                stream: Firestore.instance
                    .collection(sliderData)
                    .orderBy(sliderDate, descending: true)
                    .limit(1)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //return buildShimmer();
                    return new Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)));
                  } else {
                    final int dataCount = snapshot.data.documents.length;
                    //print("data count $dataCount");
                    if (dataCount == 0) {
                      return new Container(
                        height: 0.0,
                        width: 0.0,
                      );
                    } else {
                      return new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          return buildRecent(context, index, document);
                        },
                      );
                    }
                  }
                }),
            SizedBox(height: 20.0),

            SizedBox(height: 20.0),
            new StreamBuilder(
                stream: Firestore.instance.collection(sliderData).snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    //return buildShimmer();
                    return new Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)));
                  } else {
                    final int dataCount = snapshot.data.documents.length;
                    //print("data count $dataCount");
                    if (dataCount == 0) {
                      return new Container(
                        height: 0.0,
                        width: 0.0,
                      );
                    } else {
                      return new ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataCount,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot document =
                              snapshot.data.documents[index];
                          return buildDisp(context, index, document);
                        },
                      );
                    }
                  }
                }),

            //  new StreamBuilder(
            // stream: firestore.collection(appProducts).snapshots(),
            // builder: (context, snapshot) {
            //   if (!snapshot.hasData) {
            //     //return buildShimmer();
            //     return new Center(
            //         child: CircularProgressIndicator(
            //             valueColor: AlwaysStoppedAnimation<Color>(
            //                 Theme.of(context).primaryColor)));
            //   } else {
            //     final int dataCount = snapshot.data.documents.length;
            //     print("data count $dataCount");
            //     if (dataCount == 0) {
            //       noDataFound();
            //     } else {
            //       return new GridView.builder(
            //         gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            //             crossAxisCount: 2, childAspectRatio: 0.85),
            //         itemCount: dataCount,
            //         itemBuilder: (context, index) {
            //           final DocumentSnapshot document =
            //               snapshot.data.documents[index];
            //           return buildProducts(context, index, document);
            //         },
            //       );
            //     }
            //   }
            // }),
          ],
        ),
      ),
      // floatingActionButton: Stack(
      //   alignment: Alignment.topLeft,
      //   children: <Widget>[
      //     new FloatingActionButton(
      //       onPressed: () {
      //         Navigator.of(context).push(new CupertinoPageRoute(
      //             builder: (BuildContext context) => new BTSCart()));
      //       },
      //       child: new Icon(Icons.shopping_cart),
      //     ),
      //     // new CircleAvatar(
      //     //   radius: 10.0,
      //     //   backgroundColor: Colors.red,
      //     //   child: new Text("0",
      //     //       style: new TextStyle(color: Colors.white, fontSize: 11.0)),
      //     // )
      //   ],
      // ),

      drawer: new Drawer(
        child: new Column(
          children: <Widget>[
            SizedBox(height: 70.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new BTSSearchData()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(17.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: <Widget>[
                        Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        Text(
                          'Search',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times',
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            // new UserAccountsDrawerHeader(
            //   accountName: new Text(accName),
            //   accountEmail: new Text(accEmail),
            //   currentAccountPicture: new CircleAvatar(
            //     backgroundColor: Colors.white,
            //     child: new Icon(Icons.person),
            //   ),
            // ),

            new ListTile(
              // leading: new CircleAvatar(
              //   child: new Icon(
              //     Icons.shopping_basket,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'Market',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSLol()));
              },
            ),
            new ListTile(
              // leading: new CircleAvatar(
              //   child: new Icon(
              //     Icons.history,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'Your account',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSProfile(
                          name: accName,
                          email: accEmail,
                          status: accStatus,
                        )));
              },
            ),
            new ListTile(
              // leading: new CircleAvatar(
              //   child: new Icon(
              //     Icons.home,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'Sell',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                checkStatus();
              },
            ),
            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            new ListTile(
              // leading: new CircleAvatar(
              //   child: new Icon(
              //     Icons.person,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),

              title: new Text(
                'Settings',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSOrderHistory()));
              },
            ),

            new ListTile(
              // trailing: new CircleAvatar(
              //   child: new Icon(
              //     Icons.help,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'About us',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSAbout()));
              },
            ),
            new ListTile(
              // trailing: new CircleAvatar(
              //   child: new Icon(
              //     Icons.phone,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                'Contact us',
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: () {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new BTSContact()));
              },
            ),
            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
            new ListTile(
              // trailing: new CircleAvatar(
              //   child: new Icon(
              //     Icons.exit_to_app,
              //     color: Colors.white,
              //     size: 20.0,
              //   ),
              // ),
              title: new Text(
                accIsLoggedIn == true ? "Logout" : "Login",
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              onTap: checkIfLoggedIn,
            ),
            new Divider(
              thickness: 2.0,
              color: Colors.black,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: Colors.teal[700],
        iconSize: 30,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          //backgroundColor: Colors.green),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera),
            title: Text('Market'),
          )
          // backgroundColor: Colors.green),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // if (index == 0) {
          //   openHome();
          // }
          if (index == 1) {
            openMarket();
          }
        },
      ),
    );
  }

  checkIfLoggedIn() async {
    if (accIsLoggedIn == false) {
      bool response = await Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new BTSLogin()));
      if (response == true) getCurrentUser();
      return;
    }
    bool response = await appMethods.logOutUser();
    if (response == true) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => BTSLogin()),
          ModalRoute.withName('/'));
    }
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();

  checkStatus() async {
    getCurrentUser();
    //&& accIsLoggedIn==true
    if (accStatus == 'Seller' || accStatus == 'Both') {
      usersStatus = 'Sell';
      Navigator.of(context).push(new CupertinoPageRoute(
          builder: (BuildContext context) => new BTSSellCat()));
    } else {
      usersStatus = 'Buy';
      showSnackBar('You cannot sell unless you are a seller', scaffoldKey);
    }
  }

  void openHome() {
    Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new MyHomePage()));
  }

  void openMarket() {
    Navigator.of(context).push(
        new MaterialPageRoute(builder: (BuildContext context) => new BTSLol()));
  }

  Widget buildRecent(
      BuildContext context, int index, DocumentSnapshot document) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BTSShowProducts()));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Recently listed products',
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Times',
                fontWeight: FontWeight.bold),
          ),
          new Card(
            elevation: 0.0,
            color: Colors.transparent,
            child: new Container(
              width: screenSize.width,
              height: 150.0,
              child: new ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: document[sliderImage].length,
                  itemBuilder: (context, index) {
                    return new Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        new Container(
                          margin: new EdgeInsets.only(left: 5.0, right: 5.0),
                          height: 200.0,
                          width: 200.0,
                          child: FittedBox(
                              fit: BoxFit.cover,
                              child: new Image.network(
                                  document[sliderImage][index])),
                        ),
                        new Container(
                          margin: new EdgeInsets.only(left: 5.0, right: 5.0),
                          height: 140.0,
                          width: 100.0,
                          decoration:
                              new BoxDecoration(color: Colors.transparent),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAd(BuildContext context, int index, DocumentSnapshot document) {
    Size screenSize = MediaQuery.of(context).size;
    return InkWell(
      onTap: () async {
        if (await canLaunch(document[advLink])) {
          await launch(document[advLink]);
        }
        else {
          showSnackBar('URL cannot be launched', scaffoldKey);
        }
      },
      child: new Card(
        elevation: 0.0,
        color: Colors.transparent,
        child: new Container(
          width: screenSize.width,
          height: 170.0,
          child: FittedBox(
              fit: BoxFit.cover,
              child: new Image.network(document[advImages][0])),
        ),
      ),
    );
  }

  Widget buildProducts(
      BuildContext context, int index, DocumentSnapshot document) {
    List productImage = document[productImages] as List;
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
            builder: (context) => new ItemDetails(
                  itemImage: productImage[0],
                  itemImages: productImage,
                  itemSubName: document[productCategory],
                  itemName: document[productTitle],
                  itemPrice: document[productPrice],
                  itemDescription: document[productDesc],
                  itemRating: storeItems[index].itemRating,
                )));
      },
      child: new Card(
        child: Stack(
          alignment: FractionalOffset.topLeft,
          children: <Widget>[
            new Stack(
              alignment: FractionalOffset.bottomCenter,
              children: <Widget>[
                new Container(
                  decoration: new BoxDecoration(
                      image: new DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: new NetworkImage(productImages[0]))),
                ),
                new Container(
                  height: 50.0,
                  width: 150.0,
                  color: Colors.black.withAlpha(100),
                  child: Column(
                    children: <Widget>[
                      new Text(
                        "${document[productTitle]}",
                        style: new TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16.0,
                            color: Colors.white),
                      ),
                      new Text(
                        "Rs${document[productPrice]}",
                        style: new TextStyle(
                            color: Colors.red[500],
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                  height: 30.0,
                  width: 60.0,
                  decoration: new BoxDecoration(
                      color: Colors.black,
                      borderRadius: new BorderRadius.only(
                        topRight: new Radius.circular(5.0),
                        bottomRight: new Radius.circular(5.0),
                      )),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Icon(
                        Icons.star,
                        color: Colors.blue,
                        size: 20.0,
                      ),
                      new Text(
                        "${storeItems[index].itemRating}",
                        style: new TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                new IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.blue),
                    onPressed: () {})
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDisp(BuildContext context, int index, DocumentSnapshot document) {
    List<NetworkImage> images = List<NetworkImage>();

    for (int i = 0; i < document[sliderImage].length; i++) {
      images.add(NetworkImage('${document[sliderImage][i]}'));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            document[sliderName],
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Times',
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10.0,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new BTSShowClick(
                        title: document[sliderName],
                      )));
            },
            child: Container(
              height: 200,
              child: Carousel(
                boxFit: BoxFit.fill,
                images: images,
                autoplay: true,
                indicatorBgPadding: 0.0,
                dotColor: Colors.black,
                dotSize: 4.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOffer(
      BuildContext context, int index, DocumentSnapshot document) {
    List<NetworkImage> images = List<NetworkImage>();

    for (int i = 0; i < document[offerImages].length; i++) {
      images.add(NetworkImage('${document[offerImages][i]}'));
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            height: 200,
            child: Carousel(
              boxFit: BoxFit.fill,
              images: images,
              autoplay: true,
              indicatorBgPadding: 0.0,
              dotColor: Colors.black,
              dotSize: 4.0,
            ),
          ),
        ],
      ),
    );
  }
}
