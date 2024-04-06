import 'package:finflow/user_authentication.dart';
import 'package:finflow/user_model.dart';
import 'package:get/get.dart';

class AddController extends GetxController {
  static AddController get instance => Get.find();
  final userRepo = Get.put(UserRepository());

  Future<void> addDetails(UserModal user, String userid) async {
    await userRepo.createuser(user, userid);
  }
}
