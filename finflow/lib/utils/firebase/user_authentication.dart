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

  maketransaction(UserModal4 user) async {
    final currentUserId = await retrieveData("UserID");
    await _db.collection("${currentUserId}Transtactions").add(user.toJson());
  }

  Future<void> makeGroupTransaction(String documentId,
      Map<String, Map<String, dynamic>> transactionData) async {
    final transactionRef = _db.collection("Groups").doc(documentId);

    // Update the document with the provided transactionData
    await transactionRef.update({
      'Transactions': transactionData,
    });
  }

  Future<void> addGroupDues(String documentId,
      Map<String, Map<String, dynamic>> transactionData) async {
    final transactionRef = _db.collection("Groups").doc(documentId);

    // Update the document with the provided transactionData
    await transactionRef.update({
      'Dues': transactionData,
    });
  }

  addgroup(UserModal3 user) async {
    final currentUserId = await retrieveData("UserID");
    await _db.collection("${currentUserId}Groups").add(user.toJson());
  }

  addtoAllgroups(UserModal3 user) async {
    await _db.collection("Groups").add(user.toJson());
  }

  addtoAllTransactions(UserModal4 user) async {
    await _db.collection("Transaction").add(user.toJson());
  }

  createuser(UserModal user) async {
    final currentUserId = await retrieveData("UserID");
    await _db.collection("${currentUserId}Cards").add(user.toJson());
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

  Future<List<UserModal3>> getallgroups(String useruid) async {
    final snapshot = await _db.collection(useruid).get();
    final userdata =
        snapshot.docs.map((e) => UserModal3.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<UserModal2> getUserdetails(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection("Users").doc(uid).get();

    if (snapshot.exists) {
      return UserModal2.fromSnapshot(snapshot);
    } else {
      throw Exception('User with UID $uid not found');
    }
  }

  Future<List<UserModal4>> getalltransactions(String useruid) async {
    final snapshot = await _db.collection(useruid).get();
    final userdata =
        snapshot.docs.map((e) => UserModal4.fromSnapshot(e)).toList();
    return userdata;
  }

  Future<UserModal3> getGroupDetails(String documentName) async {
/*     final currentUserId = await retrieveData("UserID");
 */
    final snapshot = await _db
        .collection("Groups")
        .doc(documentName) // Use doc() with the provided document name
        .get();

    if (snapshot.exists) {
      final userdata = UserModal3.fromSnapshot(snapshot);
      return userdata;
    } else {
      throw Exception("Document not found");
    }
  }

  Future<List<UserModal3>> getGroupForTransaction(
      String phoneNumber, String mynumber) async {
    // Query all groups of the current user
    final groupsSnapshot = await _db.collection("Groups").get();

    final List<UserModal3> matchingGroups = [];

    for (final groupDoc in groupsSnapshot.docs) {
      final groupData = groupDoc.data();

      // Check if the group has members
      if (groupData.containsKey("Memebers")) {
        final members = Map<String, dynamic>.from(groupData["Memebers"]);

        // Check if mynumber and phoneNumber are present in the group's members
        if (members.containsValue(mynumber) &&
            members.containsValue(phoneNumber)) {
          // If found, convert to UserModal3 and add to the list
          final groupDetails = UserModal3.fromSnapshot(groupDoc);
          matchingGroups.add(groupDetails);
        }
      }
    }

    // Return the list of all matching groups, or an empty list if none found
    return matchingGroups;
  }

  Future<List<UserModal3>> getGroupsForPhoneNumber(String phoneNumber) async {
    List<UserModal3> userGroups = [];

    final snapshot = await _db.collection("Groups").get();
    final userData =
        snapshot.docs.map((e) => UserModal3.fromSnapshot(e)).toList();

    for (var user in userData) {
      // Iterate through each group's members to check if the phoneNumber is present
      bool phoneNumberFound = false;
      user.member.forEach((key, value) {
        if (value.toString().replaceAll('+91', '').replaceAll(' ', '') ==
            phoneNumber.replaceAll('+91', '').replaceAll(' ', '')) {
          phoneNumberFound = true;
        }
      });

      // If phoneNumber is found in the group, add it to the list
      if (phoneNumberFound) {
        userGroups.add(user);
      }
    }

    return userGroups;
  }
}
