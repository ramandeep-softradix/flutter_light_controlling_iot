import 'package:get/get.dart';
import 'package:flutter_smart_lighting/features/signup/controller/sign_up_controller.dart';

 class SignUpBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignUpController>(() => SignUpController());
  }

}