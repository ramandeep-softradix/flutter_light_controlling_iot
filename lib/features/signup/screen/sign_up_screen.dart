import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_lighting/Core/common_ui/common_button/common_button.dart';
import 'package:flutter_smart_lighting/Core/common_ui/text/app_text_widget.dart';
import 'package:flutter_smart_lighting/Core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:flutter_smart_lighting/Core/theme/app_color_palette.dart';
import 'package:flutter_smart_lighting/features/signup/controller/sign_up_controller.dart';

import '../../../Core/appbar/common_appbar.dart';
import '../../../Core/utils/common_string.dart';
import '../../../Core/common_ui/asset_widget/common_image_widget.dart';
import '../../../Core/utils/image_resources.dart';

class SignUpScreen extends GetView<SignUpController> {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  commonAppBarWidget(title: CommonString.signup),
                  SizedBox(height: 30.h),
                  signuptitleTextWidget(),
                  SizedBox(height: 10.h),
                  filldetailTextWidget(),
                  SizedBox(height: 20.h),
                  nameTextFieldWidget(),
                  SizedBox(height: 20.h),
                  surNameTextFieldWidget(),
                  SizedBox(height: 20.h),
                  emailTextFieldWidget(),
                  SizedBox(height: 20.h),
                  passwordTextFieldWidget(),
                  SizedBox(height: 20.h),
                  SignUpButtonWidget(),
                  SizedBox(height: 10.h),
                  loginButtonWidget(),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ));
  }

  Widget signuptitleTextWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppTextWidget(
        text: CommonString.signup.tr,
        style: CustomTextTheme.heading1WithLetterSpacing(color: Colors.black),
      ).paddingOnly(left: 16.w),
    );
  }

  Widget filldetailTextWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: AppTextWidget(
        text: CommonString.filldetailforsignup.tr,
        style: CustomTextTheme.subtext(color: Colors.black),
      ).paddingOnly(left: 16.w),
    );
  }

  Widget nameTextFieldWidget() {
    return commonTextFieldWidget(
            controller: controller.nameController,
            hint: CommonString.usernameplaceholder.tr,
            title: CommonString.username.tr,
            focusNode: controller.nameFocusNode())
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget surNameTextFieldWidget() {
    return commonTextFieldWidget(
            controller: controller.surnameController,
            hint: CommonString.usersurnameplaceholder.tr,
            title: CommonString.usersurnameplaceholder.tr,
            focusNode: controller.surNameFocusNode())
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget emailTextFieldWidget() {
    return commonEmailTextFieldWidget(
            controller: controller.emailController,
            hint: CommonString.emailplaceholder.tr,
            title: CommonString.email.tr,
            focusNode: controller.emailFocusNode(),
            isShowCrossIcon: true)
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget passwordTextFieldWidget() {
    return commonPasswordText(
            title: CommonString.password.tr,
            hint: CommonString.passwordplaceholder.tr,
            passwordVisible: true,
            controller: controller.passwordController,
            focusNode: controller.passwordFocusNode())
        .paddingOnly(left: 16.w, right: 16.w);
  }

  Widget SignUpButtonWidget() {
    return commonButtonWithBorder(
            onPress: () {
              controller.signUpValidation();
            },
            commonButtonBottonText: CommonString.signup.tr)
        .paddingSymmetric(horizontal: 16.w);
  }

  Widget loginButtonWidget() {
    return Container(
        child: Align(
      alignment: Alignment.center,
      child: InkWell(
        onTap: () => Get.back(),
        child: RichText(
          text: TextSpan(
            text: CommonString.alreadyAccount.tr,
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: CommonString.login.tr,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    ));
  }
}
