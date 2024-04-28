import 'package:finflow/utils/firebase/user_authentication.dart';
import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  static AddController get instance => Get.find();
  final userRepo = Get.put(UserRepository());

  Future<void> addDetails(UserModal user) async {
    await userRepo.createuser(user);
  }

  Future<void> addGroup(UserModal3 user) async {
    await userRepo.addgroup(user);
  }

  Future<void> addToAllGroups(UserModal3 user) async {
    await userRepo.addtoAllgroups(user);
  }

  Future<void> makeGroupTransaction(
      String docid, Map<String, Map<String, dynamic>> data) async {
    await userRepo.makeGroupTransaction(docid, data);
  }

  Future<void> addGroupDues(
      String docid, Map<String, Map<String, dynamic>> data) async {
    await userRepo.addGroupDues(docid, data);
  }

  Future<void> addUser(UserModal2 user2, String useruid) async {
    await userRepo.adduser(user2, useruid);
  }

  Future<void> addtransaction(UserModal4 user) async {
    await userRepo.maketransaction(user);
  }
}
