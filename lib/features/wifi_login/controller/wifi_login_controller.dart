import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';
import 'package:get_storage/get_storage.dart';

import 'package:loggerx/loggerx.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Core/utils/common_string.dart';

class WifiLoginController extends GetxController {
  RxBool isLoginViewHiden = true.obs;
  TextEditingController wifiNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var wifiNameFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;
  bool singleTap = false;

  RxString wifiSsid = 'N/A'.obs;
  RxString bssid = 'N/A'.obs;

  addFocusListeners() {
    wifiNameFocusNode.value.addListener(() {
      wifiNameFocusNode.refresh();
    });
    passwordFocusNode.value.addListener(() {
      passwordFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    wifiNameFocusNode.value.removeListener(() {});
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
    setNetwork();
    super.onInit();
  }

  Future<void> setNetwork() async {
    final info = NetworkInfo();
    // var locationStatus = await Permission.location.status;
    // if (locationStatus.isDenied) {
    //   await Permission.locationWhenInUse.request();
    //   print("Here is qwwwer");
    // }
    // if (await Permission.location.isRestricted) {
    //   openAppSettings();
    // }

      var wifiName = await info.getWifiName();
      print('wifiName $wifiName');
      wifiSsid.value = wifiName ?? "";
      var wifiBssid = await info.getWifiBSSID();
      print('wifiBssid $wifiBssid');
      bssid.value = wifiBssid ?? "";

  }
  validation() async {
    if (!singleTap) {
      if (wifiNameController.text.isEmpty) {
        snackbar(Validations.enterwifiname.tr);
      } else if (passwordController.text.isEmpty) {
        snackbar(Validations.enterwifipassword.tr);
      } else if (passwordController.text.length < 8) {
        snackbar(Validations.msgminwifipasswordatleast.tr);
      } else {
        gotoDashboardScreen();
       }
      singleTap = true;
      Future.delayed(const Duration(seconds: 3))
          .then((value) => singleTap = false);
    }
  }

  void smartConfig({required String ssid, required String password}) async {
    logging.level = LogLevel.debug;

    final provisioner = Provisioner.espTouch();

    await provisioner.listen((response) {
      log.info("\n"
          "\n------------------------------------------------------------------------\n"
          "Device ($response) is connected to WiFi!"
          "\n------------------------------------------------------------------------\n");
    });

    try {
      await provisioner.start(ProvisioningRequest.fromStrings(
        ssid: ssid,
        bssid: bssid.value,
        password: password,
      ));
      print("ssid $ssid");
      print("password $password");

      await Future.delayed(Duration(seconds: 10));
    } catch (e, s) {
      log.error(e, s);
    }
    snackbar("Not Connected!");
    provisioner.stop();
  }

  gotoSignupScreen() {
    Get.toNamed(MyRoutes.signUpscreen);
  }

  gotoDashboardScreen() {
    Get.toNamed(MyRoutes.bottomtabscreen);
  }

}