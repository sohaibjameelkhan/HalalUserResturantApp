import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:halal_food_user_app/Models/user_model.dart';

class UserServices {
  ///Create User
  Future createUser(UserModel userModel) async {
    DocumentReference docRef = FirebaseFirestore.instance
        .collection("userCollection")
        .doc(userModel.userID);
    return await docRef.set(userModel.toJson(docRef.id));
  }

  ///Fetch User Record
  Stream<UserModel> fetchUserRecord(String userID) {
    return FirebaseFirestore.instance
        .collection("userCollection")
        .doc(userID)
        .snapshots()
        .map((userData) => UserModel.fromJson(userData.data()!));
  }

  ///Update user record with Image

  Future updateUserDetailswithImage(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection("userCollection")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "fullName": userModel.fullName,
      "userImage": userModel.userImage,
    }, SetOptions(merge: true));
  }

  ///Update user record with Image

  Future updateUserDetailsWithoutImage(UserModel userModel) async {
    return await FirebaseFirestore.instance
        .collection("userCollection")

        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "fullName": userModel.fullName,

    }, SetOptions(merge: true));
  }
}
