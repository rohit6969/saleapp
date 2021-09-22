//Every method in the code is right here

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AppMethods {
  Future<String> loginUser({String email, String password});
  Future<String> createUserAccount(
      {String fullname,
      String status,
      String email,
      String password,
      String phone,
      String city,
      String state,
      String country,
      String street});
  Future<String> sellInit(
      {String pname, String condition, String warranty, String color});

  //Future <String> requestProduct({String pname,String condition,String warranty,String color,String info,String description});
  Future<bool> logOutUser();
  Future<DocumentSnapshot> getUserInfo(String userid);
  Future<String> addNewProduct({Map newProduct});
  Future<String> addNewAd({Map newProduct});
  Future<String> addNewOffer({Map newProduct});
  Future<String> addNewSlider({Map newSlider});
  Future<String> addCart({Map newCart});
  Future<bool> deleteCart({String docID});
  Future<String> requestProductAdd({Map newRequest});
  Future<List<String>> uploadProductImages(
      {List<File> imageList, String docID});
  Future<List<String>> adImageUpload({List<File> imageList, String docID});
  Future<List<String>> offerImageUpload({List<File> imageList, String docID});

  Future<List<String>> requestImage({List<File> imageList, String docID});
  Future<bool> updateProductImages({
    String docID,
    List<String> data,
  });

  Future<bool> updateAdImages({
    String docID,
    List<String> data,
  });

  Future<bool> updateOfferImages({
    String docID,
    List<String> data,
  });

  Future<bool> updateSliderImages(
      {String docID,
      List sliderImages,
      String sliderDates,
      List<String> sliderTitles,
      List<String> sliderIDs});
  Future<bool> updateReqImage({
    String docID,
    List<String> data,
  });
}
