import 'package:flutter_smart_lighting/features/devices/controller/device_controller.dart';
import 'package:get/get.dart';

class DeviceBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DeviceController());
  }
}
