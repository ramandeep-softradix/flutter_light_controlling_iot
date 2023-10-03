import 'package:flutter/animation.dart';
import 'package:flutter_smart_lighting/features/devices/provider/device_provider.dart';
import 'package:get/get.dart';

import '../../../Core/utils/Routes.dart';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isDarkMode = false.obs;
  var deviceModel = Get.arguments;
  RxString devicename = "".obs;

  final Duration duration = const Duration(milliseconds: 600);

  late AnimationController animationController;
  DeviceProvider deviceProvider = DeviceProvider();

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: duration);
    isDarkMode.value = deviceModel["status"];
    devicename.value = deviceModel["devicename"];
    print(isDarkMode.value);
    if (isDarkMode.value) {
      animationController.reverse(from: 1.0);
    } else {
      animationController.forward(from: 0.0);
    }
    super.onInit();
  }

  updateLightStatus() async {
    await deviceProvider.updateDeviceStatus(
        status: isDarkMode.value, deviceUid: deviceModel["uid"]);
  }

     gobackDeviceScreen(){

  }

  changeThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      animationController.reverse(from: 1.0);
    } else {
      animationController.forward(from: 0.0);
    }
    updateLightStatus();
  }
}
