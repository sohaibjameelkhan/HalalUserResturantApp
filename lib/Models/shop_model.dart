// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

ShopModel contactModelFromJson(String str) =>
    ShopModel.fromJson(json.decode(str));

String contactModelToJson(ShopModel data) =>
    json.encode(data.shopId.toString());

class ShopModel {
  ShopModel(
      {
        this.userID,
      this.shopId,
      this.name,
      this.description,
      this.phone,
      this.images,
      this.address,
      this.email,
      this.isFavorite,
      this.latitude,
      this.longitude

      //this.isFavourite=false
      });

  String? userID;
  String? shopId;
  String? name;
  String? description;
  String? phone;
  String? images;
  String? address;
  String? email;
  bool? isFavorite;
  var latitude;
  var longitude;

  //bool isFavourite;

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(

        userID: json["userID"],
        shopId: json["shopId"],
        name: json["name"],
        description: json["description"],
    phone: json["phone"],
        images: json["images"],
        address: json["address"],
        email: json["email"],
        isFavorite: json["isFavorite"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson(String docID) => {
        "userID": userID,
        "shopId": docID,
        "name": name,
        "description": description,
        "phone": phone,
        "images": images,
        "address": address,
        "email": email,
        "isFavorite": isFavorite,
        "latitude": latitude,
        "longitude": longitude,
      };
}
