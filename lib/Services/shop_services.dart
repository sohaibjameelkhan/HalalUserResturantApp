import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halal_food_user_app/Helpers/helper.dart';
import 'package:halal_food_user_app/Models/shop_model.dart';

class ShopServices {
  //Add Contact
  Future createContact(ShopModel contactModel) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("shops").doc();
    return await docRef.set(contactModel.toJson(docRef.id));
  }

  ///Update Contact with image
  Future updateContactwithImage(ShopModel contactModel) async {
    return await FirebaseFirestore.instance
        .collection("shops")
        .doc(contactModel.shopId)
        .set({
      "name": contactModel.name,
      "description": contactModel.description,
      "address": contactModel.address,
      "shopImage": contactModel.images,
      "email": contactModel.email,
    }, SetOptions(merge: true));
  }

  ///Update Contact without image
  Future updateContactwithoutImage(ShopModel contactModel) async {
    return await FirebaseFirestore.instance
        .collection("shops")
        .doc(contactModel.shopId)
        .set({
      "name": contactModel.name,
      "description": contactModel.description,
      "address": contactModel.address,
    }, SetOptions(merge: true));
  }

  ///Update Contact without image
  Future updateShopFavourite(ShopModel shopModel) async {
    return await FirebaseFirestore.instance
        .collection("shops")
        .doc(shopModel.shopId)
        .set({
     // "shopId": shopModel.shopId,
      "isFavorite": shopModel.isFavorite,
      "userID":getUserID()
    },SetOptions(merge: true) );
  }

  ///Get All contacts
  Stream<List<ShopModel>> streamContacts() {
    return FirebaseFirestore.instance
        .collection('shops')
        //  .where('userID', isEqualTo: getUserID())
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ShopModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Get All Favourite  Shops
  Stream<List<ShopModel>> streamFavouriteShops() {
    return FirebaseFirestore.instance
        .collection('shops')
        .where('isFavorite', isEqualTo: true)
        .where('userID', isEqualTo: getUserID())
        .snapshots()
        .map((list) => list.docs
            .map((singleDoc) => ShopModel.fromJson(singleDoc.data()))
            .toList());
  }

  ///Delete Product
  Future deleteContact(String contactID) async {
    return await FirebaseFirestore.instance
        .collection("contactsCollection")
        .doc(contactID)
        .delete();
  }
}
