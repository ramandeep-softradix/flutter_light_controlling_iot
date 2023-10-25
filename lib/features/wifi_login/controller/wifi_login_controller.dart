import 'dart:io';

import 'package:dio/dio.dart';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';

import 'package:loggerx/loggerx.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../Core/utils/common_string.dart';
import 'package:http/http.dart' as http;
class WifiLoginController extends GetxController {
  RxBool isLoginViewHiden = true.obs;
  TextEditingController wifiNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var wifiNameFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;
  bool singleTap = false;
  RxBool passwordVisibility = false.obs;
  RxList wifiNetwork = [].obs;

  RxString wifiSsid = 'N/A'.obs;
  RxString bssid = 'N/A'.obs;
  var client = HttpClient();




  passwordShowHide() {
    passwordVisibility.value = !passwordVisibility.value;
  }

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
    turnOnBlutetooth();
    // setNetwork();
    super.onInit();
  }

  Future<void> setNetwork() async {
    final info = NetworkInfo();
    var wifiName = await info.getWifiName();
    print('wifiName $wifiName');
    wifiNameController.text = wifiName!;
    var wifiBssid = await info.getWifiBSSID();
    print('wifiBssid $wifiBssid');
    bssid.value = wifiBssid!;
    var wifiIp = await info.getWifiIP();
    print('wifiIp $wifiIp');
  }


  getNearbyWifi() async {
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      await Permission.locationWhenInUse.request();
      print("Here is qwwwer");
    } else if (await Permission.location.isRestricted) {
      openAppSettings();
    } else {
      setNetwork();
    }
  }


  turnOnBlutetooth() async {
    var locationStatus = await Permission.bluetooth.status;
    if (locationStatus.isDenied) {
      await Permission.bluetooth.request();
      print("Here is qwwwer");
    } else if (await Permission.bluetooth.isRestricted) {
      print("Here is isRestricted");
      openAppSettings();
    } else {
      shareWifiSsidPassword();
    }
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

      }
      singleTap = true;
      Future.delayed(const Duration(seconds: 3))
          .then((value) => singleTap = false);
    }
  }
  shareWifiSsidPassword() async{
     FlutterBluePlus.scanResults.listen((results) {
       
       var deviceName="ESP32-Bluetooth-WiFi";
       var result=results;
          var k=result.where((element) => element.device.platformName.toLowerCase()==deviceName.toString().toLowerCase());
       if (k.first.device.platformName == "ESP32-Bluetooth-WiFi") {
         print("connected");
         // connectAndSendData(result.device);
         k.first.device.connect();
        
       }
       
       // for (ScanResult result in results) {
       //   // print("test >>>>${result.device}");
       //   if (result.device.platformName.toString() == "ESP32-Bluetooth-WiFi") {
       //     print("connected");
       //     // connectAndSendData(result.device);
       //     result.device.connect();
       //     break;
       //   }
       // }
     });
    FlutterBluePlus.startScan();
  }
  gotoSignupScreen() {
    Get.toNamed(MyRoutes.signUpscreen);
  }

  gotoDashboardScreen() {
    Get.toNamed(MyRoutes.bottomtabscreen);
  }

  void connectAndSendData(BluetoothDevice device) async {
      await device.connect();
      List<BluetoothService> services = await device.discoverServices();

      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          if (characteristic.uuid.toString() == "SSID_Characteristic") {
            // Format SSID data as bytes
            String ssid = "vivo Y20T"; // Replace with your SSID
            List<int> ssidBytes = ssid.codeUnits;

            // Write SSID data
            await characteristic.write(ssidBytes, withoutResponse: true);
          } else if (characteristic.uuid.toString() == "Password_Characteristic") {
            // Format password data as bytes
            String password = "123456799"; // Replace with your password
            List<int> passwordBytes = password.codeUnits;

            // Write password data
            await characteristic.write(passwordBytes, withoutResponse: true);
          }
        }
      }

      // Disconnect from the ESP32 after sending data
      device.disconnect();

  }

}
