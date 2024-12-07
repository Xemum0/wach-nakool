import 'package:get/get.dart';

class UserController extends GetxController {
  var username = 'Sarah Mb'.obs;
  var email = ''.obs;
  
  void setUsername(String newUsername) {
    username.value = newUsername;
  }
  
  void setEmail(String newEmail) {
    email.value = newEmail;
  }
}

final userController = Get.find<UserController>();