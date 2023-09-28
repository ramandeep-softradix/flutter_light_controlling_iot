import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void onInit() {
    nameController.text = "Jass";
    surnameController.text = "Chahal";
    emailController.text = "jass@gmail.com";
    super.onInit();
  }
}
