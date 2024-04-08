import 'package:finflow/utils/firebase/model/user_model.dart';
import 'package:finflow/utils/firebase/user_authentication.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FetchController extends GetxController {
  static FetchController get instance => Get.find();

  final _user = Get.put(UserRepository());

  Future<List<UserModal>> getallcards(String uid) async {
    return await _user.allcards(uid);
  }

  Future<UserModal2> getUserDetails(String uid) async {
    return await _user.getUserdetails(uid);
  }

  Future<List<UserModal2>> getallusers() async {
    return await _user.getallusers();
  }

  Future<List<UserModal3>> getallgroups(String uid) async {
    return await _user.getallgroups(uid);
  }

  Future<List<UserModal4>> getalltransactions(String uid) async {
    return await _user.getalltransactions(uid);
  }
}
