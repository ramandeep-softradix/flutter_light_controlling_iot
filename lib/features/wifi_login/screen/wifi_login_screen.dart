import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_lighting/features/wifi_login/controller/wifi_login_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/utils/common_string.dart';
import 'package:flutter_smart_lighting/Core/common_ui/asset_widget/common_image_widget.dart';
import 'package:flutter_smart_lighting/Core/common_ui/common_button/common_button.dart';
import 'package:flutter_smart_lighting/Core/common_ui/text/app_text_widget.dart';
import 'package:flutter_smart_lighting/Core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:flutter_smart_lighting/Core/utils/image_resources.dart';
import 'package:flutter_smart_lighting/features/Login/controller/login_controller.dart';

import '../../../Core/appbar/common_appbar.dart';
import '../../../Core/theme/app_color_palette.dart';

class WifiLoginScreen extends GetView<WifiLoginController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        backgroundColor: Colors.white,
        appBar:commonAppBarWidget(title: CommonString.wifiLogin),
        body: Column(
          children: [
            SizedBox(height: 20.h),
            topImageWidget(),
            SizedBox(height: 20.h),
            welcometitleTextWidget(),
            SizedBox(height: 5.h),
            filldetailTextWidget(),
            SizedBox(height: 20.h),
            emailTextFieldWidget(),
            SizedBox(height: 20.h),
            passwordTextFieldWidget(),
            SizedBox(height: 40.h),
            loginButtonWidget(),
          ],
        )));
  }

  Widget topImageWidget() {
    return AssetWidget(
        asset: Asset(type: AssetType.png, path: ImageResource.wifi),height: 100.h,width: 100.h,);
  }

  Widget welcometitleTextWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: AppTextWidget(
        text: CommonString.wifiLogin.tr,
        style: CustomTextTheme.heading1WithLetterSpacing(
          color: lightColorPalette.black,
        ),
      ).paddingOnly(left: 16.w),
    );
  }

  Widget filldetailTextWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppTextWidget(
        text: CommonString.fillbelowDetail.tr,
        style: CustomTextTheme.subtext(color: Colors.black),
      ).paddingOnly(left: 16.w),
    );
  }

  Widget emailTextFieldWidget() {
    return commonEmailTextFieldWidget(
            controller: controller.wifiNameController,
            hint: CommonString.wifinameplaceholder.tr,
            title: CommonString.wifiSSID.tr,
            focusNode: controller.wifiNameFocusNode(),
            isShowCrossIcon: true)
        .paddingSymmetric(horizontal: 16.w);
  }

  Widget passwordTextFieldWidget() {
    return commonPasswordText(
            title: CommonString.wifipassword.tr,
            passwordVisible: true,
            hint: CommonString.wifipasswordplaceholder.tr,
            controller: controller.passwordController,
            focusNode: controller.passwordFocusNode())
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget loginButtonWidget() {
    return commonButtonWithBorder(
            onPress: () {
              controller.validation();
            },
            commonButtonBottonText: CommonString.connect.tr)
        .paddingOnly(left: 16.w, right: 16.w);
  }
}
