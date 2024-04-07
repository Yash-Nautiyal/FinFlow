import 'dart:html';

import 'package:finflow/pages/login/login.dart';
import 'package:finflow/pages/login/phone.dart';
import 'package:finflow/pages/login/verify.dart';
import 'package:finflow/screens.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseuser;

  @override
  void onReady() {
    firebaseuser = Rx<User?>(_auth.currentUser);
    firebaseuser.bindStream(_auth.userChanges());
    ever(firebaseuser, (callback) => _setinitalscreen);
  }

  _setinitalscreen(User? user) {
    user != firebaseuser
        ? Get.offAll(() => const LoginPage())
        : Get.offAll(() => const Screens());
  }
}
