//import 'package:flutter/material.dart';
// get
import 'package:get/get.dart';
import 'package:hackaton/ui/ui.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();

  @override
  void onReady() async {
    /* 
    if(true) {
      Get.offAll(SignInUI());
    } else { */
//    Get.offAll(ExplorerUI());
    /* } */

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
