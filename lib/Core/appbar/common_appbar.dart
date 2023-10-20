import 'package:flutter/material.dart';
import 'package:flutter_smart_lighting/Core/common_ui/text/app_text_widget.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';
import 'package:flutter_smart_lighting/features/bottom_tabs/controller/bottom_tab_controller.dart';
import 'package:flutter_smart_lighting/features/bottom_tabs/screen/bottom_tab_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/theme/app_color_palette.dart';

commonAppBarWidget({bool isShowBacIcon = true,required String title,bool isBack = false}) {
  return AppBar(
    backgroundColor: lightColorPalette.black,
    leading:  Visibility(
      visible: isShowBacIcon,
      child: IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => isBack ? Get.offNamedUntil(MyRoutes.bottomtabscreen, (route) => false) : Get.back(),
      ),
    ),
    title: AppTextWidget(
      text: title,
      style: CustomTextTheme.heading3(color: Colors.white),
    ),
  );
}
