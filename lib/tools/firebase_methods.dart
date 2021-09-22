//Methods to connect to our firebase

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'app_tools.dart';
import 'appmethods.dart';
import 'app_data.dart';

class FirebaseMethods implements AppMethods {
  Firestore firestore = Firestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<String> createUserAccount(
      {String fullname,
      String status,
      String email,
      String password,
      String phone,
      String city,
      String state,
      String country,
      String street}) async {
    // TODO: implement createUserAccount
    FirebaseUser user;
    try {
      user = (await auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        await firestore.collection(usersData).document(user.uid).setData({
          userID: user.uid,
          fullName: fullname,
          userEmail: email,
          phoneNumber: phone,
          userPassword: password,
          userStatus: status,
          userStreet: street,
          userState: state,
          userCity: city,
          userCountry: country
        });
        writeDataLocally(key: userID, value: user.uid);
        writeDataLocally(key: fullName, value: fullname);
        writeDataLocally(key: userEmail, value: email);
        writeDataLocally(key: phoneNumber, value: phone);
        writeDataLocally(key: userPassword, value: password);
        writeDataLocally(key: userStatus, value: status);
        writeDataLocally(key: userStreet, value: street);
        writeDataLocally(key: userState, value: state);
        writeDataLocally(key: userCity, value: city);
        writeDataLocally(key: userCountry, value: country);
      }
    } on PlatformException catch (e) {
      //print (e.details);
      return errorMSG(e.message);
    }

    return user == null ? errorMSG("Error") : successfulMSG();
  }

  Future<String> sellInit(
      {String pname, String condition, String warranty, String color}) async {
    writeDataLocally(key: pname, value: pname);
    writeDataLocally(key: pcondition, value: condition);
    writeDataLocally(key: pwarranty, value: warranty);
    writeDataLocally(key: pcolor, value: color);
  }

  @override
  Future<String> loginUser({String email, String password}) async {
    // TODO: implement loginUser
    FirebaseUser user;
    try {
      user = (await auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user != null) {
        DocumentSnapshot userInfo = await getUserInfo(user.uid);
        await writeDataLocally(key: fullName, value: userInfo[fullName]);
        await writeDataLocally(key: userID, value: userInfo[userID]);
        await writeDataLocally(key: userEmail, value: userInfo[userEmail]);
        await writeDataLocally(key: photoURL, value: userInfo[photoURL]);
        await writeDataLocally(key: userStatus, value: userInfo[userStatus]);
        await writeDataLocally(key: phoneNumber, value: userInfo[phoneNumber]);
        await writeBoolLocally(key: loggedIn, value: true);
      }
    } on PlatformException catch (e) {
      //print (e.details);
      return errorMSG(e.message);
    }
    return user == null ? errorMSG("Error") : successfulMSG();
  }

  Future<bool> complete() async {
    return true;
  }

  Future<bool> notComplete() async {
    return true;
  }

  Future<String> successfulMSG() async {
    return successful;
  }

  Future<String> errorMSG(String e) async {
    return e;
  }

  @override
  Future<bool> logOutUser() async {
    // TODO: implement logOutUser
    await auth.signOut();
    await clearDataLocally();
    return complete();
  }

  @override
  Future<DocumentSnapshot> getUserInfo(String userid) async {
    // TODO: implement getUserInfo
    return await firestore.collection(usersData).document(userid).get();
  }

  @override
  Future<String> addNewProduct({Map newProduct}) async {
    // Implement addNewProduct
    String documentID;
    await firestore.collection(appProducts).add(newProduct).then((documentRef) {
      //return document ID
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  @override
  Future<String> addNewAd({Map newProduct}) async {
    // Implement addNewProduct
    String documentID;
    await firestore
        .collection(advertisement)
        .add(newProduct)
        .then((documentRef) {
      //return document ID
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  @override
  Future<String> addNewOffer({Map newProduct}) async {
    // Implement addNewProduct
    String documentID;
    await firestore.collection(offer).add(newProduct).then((documentRef) {
      //return document ID
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  @override
  Future<String> addNewSlider({Map newSlider}) async {
    // Implement addNewSlider
    String documentID;
    await firestore.collection(sliderData).add(newSlider).then((documentRef) {
      //return document ID
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  Future<bool> deleteCart({String docID}) async {
    bool result;
    await firestore
        .collection(userCart)
        .document(docID)
        .delete()
        .whenComplete(() {
      result = true;
    });
    return result;
  }

  Future<String> addCart({Map newCart}) async {
    String documentID;
    await firestore.collection(userCart).add(newCart).then((documentRef) {
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  Future<String> requestProductAdd({Map newRequest}) async {
    String documentID;
    await firestore
        .collection(productRequests)
        .add(newRequest)
        .then((documentRef) {
      documentID = documentRef.documentID;
    });
    return documentID;
  }

  @override
  Future<List<String>> uploadProductImages(
      {List<File> imageList, String docID}) async {
    // TODO: implement uploadProductImages
    List<String> imagesUrl = new List();
    try {
      for (int s = 0; s < imageList.length; s++) {
        var ref = FirebaseStorage.instance
            .ref()
            .child(appProducts)
            .child(docID)
            .child(docID + "$s.jpg");
        StorageUploadTask uploadTask = ref.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        Uri downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imagesUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imagesUrl.add(error);
      print(e.details);
    }
    return imagesUrl;
  }

  Future<List<String>> requestImage(
      {List<File> imageList, String docID}) async {
    // TODO: implement uploadProductImages
    List<String> imagesUrl = new List();
    try {
      for (int s = 0; s < imageList.length; s++) {
        var ref = FirebaseStorage.instance
            .ref()
            .child(productRequests)
            .child(docID)
            .child(docID + "$s.jpg");
        StorageUploadTask uploadTask = ref.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imagesUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imagesUrl.add(error);
      print(e.details);
    }
    return imagesUrl;
  }

  Future<List<String>> adImageUpload(
      {List<File> imageList, String docID}) async {
    // TODO: implement uploadProductImages
    List<String> imagesUrl = new List();
    try {
      for (int s = 0; s < imageList.length; s++) {
        var ref = FirebaseStorage.instance
            .ref()
            .child(advertisement)
            .child(docID)
            .child(docID + "$s.jpg");
        StorageUploadTask uploadTask = ref.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imagesUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imagesUrl.add(error);
      print(e.details);
    }
    return imagesUrl;
  }

  Future<List<String>> offerImageUpload(
      {List<File> imageList, String docID}) async {
    // TODO: implement uploadProductImages
    List<String> imagesUrl = new List();
    try {
      for (int s = 0; s < imageList.length; s++) {
        var ref = FirebaseStorage.instance
            .ref()
            .child(offer)
            .child(docID)
            .child(docID + "$s.jpg");
        StorageUploadTask uploadTask = ref.putFile(imageList[s]);
        StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
        var downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
        imagesUrl.add(downloadUrl.toString());
      }
    } on PlatformException catch (e) {
      imagesUrl.add(error);
      print(e.details);
    }
    return imagesUrl;
  }

  @override
  Future<bool> updateProductImages({String docID, List<String> data}) async {
    // TODO: implement updateProductImags
    bool msg;
    await firestore
        .collection(appProducts)
        .document(docID)
        .updateData({productImages: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future<bool> updateAdImages({String docID, List<String> data}) async {
    // TODO: implement updateProductImags
    bool msg;
    await firestore
        .collection(advertisement)
        .document(docID)
        .updateData({advImages: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future<bool> updateOfferImages({String docID, List<String> data}) async {
    // TODO: implement updateProductImags
    bool msg;
    await firestore
        .collection(offer)
        .document(docID)
        .updateData({offerImages: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future<bool> updateSliderImages(
      {String docID,
      List sliderImages,
      String sliderDates,
      List<String> sliderTitles,
      List<String> sliderIDs}) async {
    // TODO: implement updateProductImags
    bool msg;
    await firestore.collection(sliderData).document(docID).updateData({
      sliderImage: sliderImages,
      sliderTitle: sliderTitles,
      sliderDate: sliderDates,
      sliderID: sliderIDs
    }).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  @override
  Future<bool> updateReqImage({String docID, List<String> data}) async {
    // TODO: implement updateProductImags
    bool msg;
    await firestore
        .collection(productRequests)
        .document(docID)
        .updateData({pImages: data}).whenComplete(() {
      msg = true;
    });
    return msg;
  }

  // @override
  // Future<String> requestProduct({String pname, String condition, String warranty, String color, String info, String description}) {
  //   // TODO: implement requestProduct
  //   throw UnimplementedError();
  // }
}
