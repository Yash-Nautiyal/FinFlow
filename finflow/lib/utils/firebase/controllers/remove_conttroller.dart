import 'package:get/get.dart';

import '../user_authentication.dart';

class RemoveController extends GetxController {
  static RemoveController get instance => Get.find();

  final _user = Get.put(UserRepository());
}
