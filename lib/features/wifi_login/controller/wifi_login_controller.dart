import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:esp_smartconfig/esp_smartconfig.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    FlutterBluePlus.startScan(timeout: Duration(seconds: 2));
    int value=0;
    FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult result in results) {
        if (result.device.platformName == "ESP32-Bluetooth-WiFi") {
          print("is device connected >>>>>>> ${result.device.platformName}");
          value=value+1;

          print("value >>>>>>> ${value}");
          if(value==1){
            FlutterBluePlus.stopScan();
            connectAndSendData(result.device);
          }
          break;
        }
      }
    });



     //
     // FlutterBluePlus.scanResults.listen((results) {
     //
     //   var deviceName="ESP32-Bluetooth-WiFi";
     //   var result=results;
     //      var k=result.where((element) => element.device.platformName.toLowerCase()==deviceName.toString().toLowerCase());
     //   if (k.first.device.platformName == "ESP32-Bluetooth-WiFi") {
     //     print("connected");
     //     // connectAndSendData(result.device);
     //     k.first.device.connect();
     //
     //   }
     //
     //   // for (ScanResult result in results) {
     //   //   // print("test >>>>${result.device}");
     //   //   if (result.device.platformName.toString() == "ESP32-Bluetooth-WiFi") {
     //   //     print("connected");
     //   //     // connectAndSendData(result.device);
     //   //     result.device.connect();
     //   //     break;
     //   //   }
     //   // }
     // });
  }
  gotoSignupScreen() {
    Get.toNamed(MyRoutes.signUpscreen);
  }

  gotoDashboardScreen() {
    Get.toNamed(MyRoutes.bottomtabscreen);
  }

  void connectAndSendData(BluetoothDevice device) async {
    await device.connect();


      print("connection done");
    int value=0;
      List<BluetoothService> services = await device.discoverServices();
      for (BluetoothService service in services) {
        for (BluetoothCharacteristic characteristic in service.characteristics) {
          print("send data ${characteristic.uuid.toString()}");
           var uuid ="00002a00-0000-1000-8000-00805f9b34fb";
          if (characteristic.uuid.toString().toLowerCase() ==
              uuid.toLowerCase()) {
            print("send data");
            value=value+1;
             writeToBluetooth(characteristic,value);

          }
        }
      }

  }

  void writeToBluetooth(BluetoothCharacteristic characteristic,value) async{

    // if(value==1){
      // Format SSID and password data
      String ssid = "vivo Y20T"; // Replace with your SSID
      String password = "123456799"; // Replace with your password
      String ssidPasswordData = "$ssid:$password";


      await characteristic.write(utf8.encode(ssidPasswordData),withoutResponse: true);
      // try {
      //   // Write the SSID and password to the ESP32
      //
      // } on PlatformException catch (e) {
      //   if (e.code == 'writeCharacteristic') {
      //     // Handle the specific error message here, e.g., show an error dialog.
      //     print('Error: The WRITE property is not supported by this BLE characteristic');
      //   } else {
      //     // Handle other types of platform exceptions if necessary.
      //   }
      // }
    }
  // }

}
