import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finflow/utils/Colors/colors.dart';
import 'package:finflow/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  createuser(UserModal user, String userid) async {
    await _db
        .collection("User_card_details")
        .doc(userid)
        .set(user.toJson())
        .whenComplete(
          () => Get.snackbar('Success', 'Your  account has been created',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: green.withOpacity(.1),
              colorText: green),
        )
        .catchError((error, stackTrace) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent.withOpacity(.1),
          colorText: Colors.redAccent);
      print(error.toString());
    });
  }

  Future<UserModal> getUserDetails(String cardnumber) async {
    final snapshot = await _db
        .collection("Users")
        .where("CardNumber", isEqualTo: cardnumber)
        .get();
    final userdata = snapshot.docs.map((e) => UserModal.fromSnapshot(e)).single;
    return userdata;
  }

  Future<List<UserModal>> alluser() async {
    final snapshot = await _db.collection("Users").get();
    final userdata =
        snapshot.docs.map((e) => UserModal.fromSnapshot(e)).toList();
    return userdata;
  }
}
