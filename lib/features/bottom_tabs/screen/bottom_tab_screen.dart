
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_lighting/Core/utils/common_string.dart';
import 'package:flutter_smart_lighting/Core/theme/app_color_palette.dart';
import 'package:flutter_smart_lighting/features/Settings/screen/setting_screen.dart';
import 'package:flutter_smart_lighting/features/bottom_tabs/controller/bottom_tab_controller.dart';
import 'package:flutter_smart_lighting/features/devices/screen/device_screen.dart';
import 'package:get/get.dart';

import '../../profile/screen/profile_screen.dart';


class BottomTabScreen extends GetView<BottomTabController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        final currentIndex = controller.currentIndex.value;
        return IndexedStack(
          index: currentIndex,
          children: [
            DeviceScreen(),
            SettingScreen(),
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: Obx(() {
        final currentIndex = controller.currentIndex.value;
        return BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 6.0,
          currentIndex: currentIndex,
          selectedItemColor: lightColorPalette.black,
          unselectedItemColor: lightColorPalette.grey,
          iconSize: 24.h,
          onTap: (index) => controller.changeTabIndex(index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.connected_tv,),
              label: CommonString.devices,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: CommonString.settings,
            ),
          ],
        );
      }),
    );
  }
}