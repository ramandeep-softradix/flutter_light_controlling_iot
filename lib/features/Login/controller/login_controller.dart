import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_lighting/Core/Firebase/firebase.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/utils/Extension.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';

import '../../../Core/utils/common_string.dart';

class LoginController extends GetxController {
  RxBool isLoginViewHiden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;
  bool singleTap = false;

  addFocusListeners() {
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });
    passwordFocusNode.value.addListener(() {
      passwordFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    emailFocusNode.value.removeListener(() {});
    passwordFocusNode.value.removeListener(() {});
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  @override
  void dispose() {
    disposeFocusListeners();
    super.dispose();
  }

  @override
  void onInit() {
    addFocusListeners();
    super.onInit();
  }

  validation() async {
    if (!singleTap) {
      if (emailController.text.isEmpty) {
        snackbar(Validations.enteremail.tr);
      } else if (!EmailValidator.validate(emailController.text)) {
        snackbar(Validations.entervaildemail.tr);
      } else if (passwordController.text.isEmpty) {
        snackbar(Validations.enterpassword.tr);
      } else if (passwordController.text.length < 8) {
        snackbar(Validations.msgminpasswordatleast.tr);
      } else if (!passwordController.text.isValidPassword()) {
        snackbar(Validations.kMsgPasswordAtleast.tr);
      } else {
        UserCredential? response = await AuthenticationHelper().login(
            email: emailController.text, password: passwordController.text);
        if (response?.user?.uid != null) {
          gotowifiScreen();
        }
      }

      singleTap = true;
      Future.delayed(const Duration(seconds: 3))
          .then((value) => singleTap = false);
    }
  }

  gotoSignupScreen() {
    Get.toNamed(MyRoutes.signUpscreen);
  }

  gotowifiScreen() {
    Get.toNamed(MyRoutes.wifiloginscreen);
  }
}
