import 'package:get/get.dart';

class LoginController extends GetxController {
  var count = 5.obs;
  increment() {
    count++;
    update(["login"]);
  }
}
