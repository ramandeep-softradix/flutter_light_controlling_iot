
import 'package:flutter_smart_lighting/features/bottom_tabs/controller/bottom_tab_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';


class BottomTabBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomTabController>(() => BottomTabController());

  }

}