import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_lighting/Core/appbar/common_appbar.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';
import 'package:flutter_smart_lighting/features/profile/controller/profile_controller.dart';
import 'package:flutter_smart_lighting/main.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../../Core/utils/common_string.dart';
import '../../../Core/common_ui/asset_widget/common_image_widget.dart';
import '../../../Core/common_ui/common_button/common_button.dart';
import '../../../Core/common_ui/text/app_text_widget.dart';
import '../../../Core/common_ui/textfields/app_common_text_form_field.dart';
import '../../../Core/theme/app_color_palette.dart';
import '../../../Core/utils/image_resources.dart';

class ProfileScreen extends GetView<ProfileController> {
  var controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:
          commonAppBarWidget(title: CommonString.profile, isShowBacIcon: false),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 20.h),
              userImageWidget(),
              // SizedBox(height: 20.h),
              // profileTextWidget(),
              SizedBox(height: 20.h),
              nameTextFieldWidget(),
              SizedBox(height: 20.h),
              surNameTextFieldWidget(),
              SizedBox(height: 20.h),
              emailTextFieldWidget(),
              SizedBox(height: 40.h),
              bottomContainerWidget(),
              SizedBox(height: 40.h),
              changePasswordButtonWidget(),
              SizedBox(height: 20.h),
              logoutButtonWidget(),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget userImageWidget() {
    return InkWell(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.r),
        child: Container(
          height: 100.h,
          width: 100.w,
          child: AssetWidget(
              asset: Asset(
                  type: AssetType.png, path: ImageResource.userplaceholder)),
        ),
      ),
    );
  }

  Widget profileTextWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppTextWidget(
        text: CommonString.profile.tr,
        style: CustomTextTheme.heading1WithLetterSpacing(color: Colors.black),
      ).paddingOnly(left: 16.w),
    );
  }

  Widget nameTextFieldWidget() {
    return commonTextFieldWidget(
            controller: controller.nameController,
            title: CommonString.username.tr,
            readOnly: true,
            focusNode: FocusNode())
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget surNameTextFieldWidget() {
    return commonTextFieldWidget(
            controller: controller.surnameController,
            readOnly: true,
            title: CommonString.usersurname.tr,
            focusNode: FocusNode())
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget emailTextFieldWidget() {
    return commonEmailTextFieldWidget(
            controller: controller.emailController,
            title: CommonString.email.tr,
            readOnly: true,
            focusNode: FocusNode(),
            isShowCrossIcon: true)
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget bottomContainerWidget() {
    return Container(
      height: 1.h,
      color: lightColorPalette.greyBg,
    ).paddingOnly(left: 16.w, right: 16.w);
  }

  Widget logoutButtonWidget() {
    return commonButtonWithBorder(
            onPress: () {
              logoutPopup();
            },
            commonButtonBottonText: CommonString.logout.tr)
        .paddingSymmetric(horizontal: 16.w);
  }

  Widget changePasswordButtonWidget() {
    return commonButtonWithBorder(
      onPress: () {},
      commonButtonBottonText: CommonString.changePassword.tr,
      bgColor: lightColorPalette.transparentColor,
      textColor: lightColorPalette.black,
    ).paddingSymmetric(horizontal: 16.w);
  }

  Widget logoutTextWidget() {
    return AppTextWidget(
      text: CommonString.logout.tr,
      style: CustomTextTheme.heading3(color: lightColorPalette.black),
    );
  }

  Widget logoutMsgTextWidget() {
    return AppTextWidget(
      text: CommonString.logoutmsg,
      style: CustomTextTheme.normalText(color: lightColorPalette.black),
    );
  }

  Widget noButtonWidget() {
    return commonButtonWithBorder(
        onPress: () {
          Get.back();
        },
        commonButtonBottonText: CommonString.no.tr,
        bgColor: lightColorPalette.transparentColor,
        textColor: lightColorPalette.black);
  }

  Widget yesButtonWidget() {
    return commonButtonWithBorder(
        onPress: () {
          Get.toNamed(MyRoutes.root);
        },
        commonButtonBottonText: CommonString.yes.tr);
  }

  logoutPopup() {
    Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Material(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        logoutTextWidget(),
                        const SizedBox(height: 15),
                        logoutMsgTextWidget(),
                        SizedBox(height: 20.h),
                        //Buttons
                        Row(
                          children: [
                            Expanded(
                              child: noButtonWidget(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: yesButtonWidget(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
