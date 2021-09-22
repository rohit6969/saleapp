import 'package:flutter/material.dart';

class Store {
  String itemName;
  double itemPrice;
  String itemImage;
  double itemRating;

  Store.items({this.itemName, this.itemPrice, this.itemImage, this.itemRating});
}

List<Store> storeItems = [
  Store.items(
      itemName: "Pink Can",
      itemPrice: 2500.00,
      itemImage: 'https://bit.ly/3exbmqn',
      itemRating: 0.0),
  Store.items(
      itemName: "Black strip white",
      itemPrice: 1500.00,
      itemImage: 'https://bit.ly/3exbiH9',
      itemRating: 0.0),
  Store.items(
      itemName: "Printed T-shirt",
      itemPrice: 500.00,
      itemImage: 'https://bit.ly/3ewKEOL',
      itemRating: 0.0),
  Store.items(
      itemName: "Dhaka topi",
      itemPrice: 3500.00,
      itemImage: 'https://bit.ly/2CFchHe',
      itemRating: 0.0),
  Store.items(
      itemName: "Dell Laptop",
      itemPrice: 50000.00,
      itemImage: 'https://bit.ly/2Nv70UR',
      itemRating: 0.0),
  Store.items(
      itemName: "Powerbank",
      itemPrice: 5500.00,
      itemImage: 'https://bit.ly/2CztJN7',
      itemRating: 0.0),
  Store.items(
    itemName: "Hard drive 1 TB",
    itemPrice: 7000.00,
    itemImage:'https://bit.ly/31gMHme',
    itemRating: 0.0
      ),
  Store.items(
    itemName: "SSD 256GB",
    itemPrice: 6500.00,
    itemImage:'https://bit.ly/3esoAVj',
    itemRating: 0.0
      ),
];
