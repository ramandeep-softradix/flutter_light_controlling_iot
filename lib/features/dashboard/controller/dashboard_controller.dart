import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_smart_lighting/features/devices/provider/device_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DashboardController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool isDarkMode = false.obs;
  RxBool lightonoff = false.obs;
  var deviceModel = Get.arguments;
  RxString devicename = "".obs;
  String lightStatus = "";

  final Duration duration = const Duration(milliseconds: 600);

  late AnimationController animationController;
  DeviceProvider deviceProvider = DeviceProvider();
  final dio = Dio();
  final String esp32IpAddress = '192.168.93.104';

  @override
  void onInit() {
    animationController = AnimationController(vsync: this, duration: duration);
    isDarkMode.value = deviceModel["status"];
    devicename.value = deviceModel["devicename"];
    print(isDarkMode.value);
    if (isDarkMode.value) {
      lightStatus = "on";
      animationController.reverse(from: 1.0);
    } else {
      lightStatus = "off";
      animationController.forward(from: 0.0);
    }
    toggleLight(lightStatus);
    super.onInit();
  }

  Future<void> toggleLight(String state) async {
    try {

      String ipAddress = esp32IpAddress;

      // light on karne ke liye request
      String onRequest = 'http://192.168.1.100/on';

      // light off karne ke liye request
      String offRequest = 'http://192.168.1.100/off';

      // light on/off karne ki request send karna
      final response= await http.get(isDarkMode.value==false ? Uri.parse(offRequest) : Uri.parse(onRequest));



      // final response = await http.get(Uri.http(esp32IpAddress, '/toggle', {'state': state}));
      print("Here is response ${response.statusCode}");
      print("Here is response ${response.body}");

      if (response.statusCode == 200) {
        print('Light is $state');
      } else {
        print('Failed to toggle light');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  updateLightStatus() async {
    await deviceProvider.updateDeviceStatus(
        status: isDarkMode.value, deviceUid: deviceModel["uid"]);
  }

  gobackDeviceScreen() {}

  changeThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      animationController.reverse(from: 1.0);
      lightStatus = "on";
    } else {
      animationController.forward(from: 0.0);
      lightStatus = "off";
    }
    toggleLight(lightStatus);
    updateLightStatus();
  }
}

