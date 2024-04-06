import 'package:finflow/user_authentication.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class FetchController extends GetxController {
  static FetchController get instance => Get.find();

  final _user = Get.put(UserRepository());

  getuserData(String cardnumber) {
    return _user.getUserDetails(cardnumber);
  }
}
