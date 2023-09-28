import 'package:flutter/animation.dart';
import 'package:get/get.dart';
class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isDarkMode = false.obs;

  final Duration duration = const Duration(milliseconds: 800);

  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: duration);
    super.onInit();
  }

  changeThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      animationController.forward(from: 0.0);
    } else {
      animationController.reverse(from: 1.0);
    }
  }

}
