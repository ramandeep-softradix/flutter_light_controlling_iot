
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_lighting/Core/utils/Extension.dart';
import 'package:get/get.dart';

import '../../../../Core/common_ui/snackbar/snackbar.dart';
import '../../../../Core/utils/common_string.dart';
import '../provider/signup_provider.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var nameFocusNode = FocusNode().obs;
  var surNameFocusNode = FocusNode().obs;

  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;
  SignUpProvider signUpProvider = SignUpProvider();
  Rx<String> pickedImageFile = "".obs;
  bool singleTap = false;
  RxBool isShowLoader = false.obs;
  RxBool passwordVisibility = false.obs;

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  passwordShowHide() {
    passwordVisibility.value = !passwordVisibility.value;
  }

  signUpValidation() async {
    if (!singleTap) {
      if (nameController.text.isEmpty) {
        snackbar(Validations.entername.tr);
      } else if (surnameController.text.isEmpty) {
        snackbar(Validations.entersurename.tr);
      } else if (emailController.text.isEmpty) {
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
        UserCredential? response = await signUpProvider.signUp(
            email: emailController.text,
            password: passwordController.text,
            username: nameController.text,
            surname: surnameController.text);
        setShowLoader(value: false);
        if (response?.user?.uid != null) {
          Get.back();
        }else{
          setShowLoader(value: false);

        }
      }
      singleTap = true;
      Future.delayed(const Duration(seconds: 3))
          .then((value) => singleTap = false);
    }
  }

  addFocusListeners() {
    nameFocusNode.value.addListener(() {
      nameFocusNode.refresh();
    });

    surNameFocusNode.value.addListener(() {
      surNameFocusNode.refresh();
    });

    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });

    passwordFocusNode.value.addListener(() {
      passwordFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    emailFocusNode.value.removeListener(() {});
    surNameFocusNode.value.removeListener(() {});

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
}
