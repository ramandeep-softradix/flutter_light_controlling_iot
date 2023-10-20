import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_lighting/Core/Firebase/firebase.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/utils/Extension.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';

import '../../../../Core/storage/local_storage.dart';
import '../../../../Core/utils/common_string.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;
  bool singleTap = false;
  RxBool isShowLoader = false.obs;
  RxBool passwordVisibility = false.obs;

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

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  passwordShowHide() {
    passwordVisibility.value = !passwordVisibility.value;
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
        setShowLoader(value: true);
        UserCredential? response = await AuthenticationHelper().login(
            email: emailController.text, password: passwordController.text);
        setShowLoader(value: false);
        print(response);
        if (response?.user?.uid != null) {
          String? token = response?.user?.uid;
          String? email = response?.user?.email;
          Prefs.write(Prefs.email, email);
          Prefs.write(Prefs.token, token);
          emptyTextFieldsData();
          goToBottomTabScreen();
        }
      }

      singleTap = true;
      Future.delayed(const Duration(seconds: 3))
          .then((value) => singleTap = false);
    }
  }

  emptyTextFieldsData() {
    emailController.text = "";
    passwordController.text = "";
  }

  gotoSignupScreen() {
    Get.toNamed(MyRoutes.signUpscreen);
  }

  goToBottomTabScreen() {
    Get.toNamed(MyRoutes.bottomtabscreen);
  }
}
