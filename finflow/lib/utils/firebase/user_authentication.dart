import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:finflow/utils/firebase/shared_preference.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  adduser(UserModal2 user, String userid) async {
    await _db.collection('Users').doc(userid).set(user.toJson());
  }

  addgroup(UserModal3 user) async {
    final currentUserId = await retrieveData("UserID");
    await _db.collection("${currentUserId}Groups").add(user.toJson());
  }

  createuser(UserModal user) async {
    final currentUserId = await retrieveData("UserID");
    await _db.collection("${currentUserId}Cards").add(user.toJson());
  }

  Future<UserModal> getUserDetails(String cardnumber) async {
    final currentUserId = await retrieveData("UserId");

    final snapshot = await _db
        .collection("${currentUserId}Cards")
        .where("CardNumber", isEqualTo: cardnumber)
        .get();
    final userdata = snapshot.docs.map((e) => UserModal.fromSnapshot(e)).single;
    return userdata;
  }

  Future<List<UserModal>> allcards(String useruid) async {
    final snapshot = await _db.collection(useruid).get();
    final userdata =
        snapshot.docs.map((e) => UserModal.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<List<UserModal2>> getallusers() async {
    final snapshot = await _db.collection("Users").get();
    final userdata =
        snapshot.docs.map((e) => UserModal2.fromSnapshot(e)).toList();
    return userdata;
  }
}
