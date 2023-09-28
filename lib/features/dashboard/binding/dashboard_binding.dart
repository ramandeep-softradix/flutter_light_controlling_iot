import 'package:flutter_smart_lighting/features/dashboard/controller/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings{
  @override
  void dependencies() {
Get.lazyPut<DashboardController>(() => DashboardController());
  }

}