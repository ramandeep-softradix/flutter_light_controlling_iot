import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_lighting/Core/appbar/common_appbar.dart';
import 'package:flutter_smart_lighting/Core/utils/common_string.dart';
import 'package:flutter_smart_lighting/Core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:flutter_smart_lighting/Core/theme/app_color_palette.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';
import 'package:get/get.dart';

import '../../../Core/common_ui/asset_widget/common_image_widget.dart';
import '../../../Core/common_ui/common_button/common_button.dart';
import '../../../Core/common_ui/text/app_text_widget.dart';
import '../../../Core/utils/image_resources.dart';

class DeviceScreen extends StatelessWidget {
  const DeviceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          commonAppBarWidget(title: CommonString.devices, isShowBacIcon: false),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: lightColorPalette.black,
        onPressed: () {
          addDeviceNetwork(title: CommonString.addDevice);
        },
      ),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          noOfDeviceTextWidget(),
          SizedBox(height: 10.h),
          deviceListViewWidget(),
        ],
      ),
    );
  }

  Widget deviceListViewWidget() {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const RangeMaintainingScrollPhysics(),
          itemCount: 5,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Get.toNamed(MyRoutes.dashboardscreen);
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 12.h),
                        child: Card(
                          color: Colors.grey[200],
                          margin: EdgeInsets.zero,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 6.h, horizontal: 6.w),
                            child: leftImageWidget(),
                          ),
                        ),
                      ),
                      SizedBox(width: 18.w),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 13.h),
                              child: titleTextWidget(title: "Vivo"),
                            ),
                            SizedBox(height: 4.h),
                            subTitleTextWidget(subTitle: "abcccc"),
                          ],
                        ),
                      ),
                      SizedBox(height: 10.h),
                      rightImageWidget()
                    ],
                  ).paddingOnly(left: 17.w, right: 17.w),
                  SizedBox(height: 10.h),
                  bottomViewWidget(color: Colors.grey[300])
                      .paddingOnly(left: 17.w, right: 17.w),
                ],
              ),
            );
          }),
    );
  }

  Widget leftImageWidget() {
    return AssetWidget(
      asset: Asset(type: AssetType.png, path: ImageResource.icnbulb),
      height: 34.h,
      width: 34.w,
    );
  }

  Widget rightImageWidget() {
    return Center(
      child: InkWell(
        onTap: () {
          addDeviceNetwork(title: CommonString.editDevice);
        },
        child: AssetWidget(
          asset: Asset(type: AssetType.png, path: ImageResource.icnedit),
          height: 20.h,
          width: 20.w,
        ),
      ),
    );
  }

  Widget noOfDeviceTextWidget() {
    return Align(
      alignment: Alignment.topLeft,
      child: AppTextWidget(
        text: CommonString.noOfDevice,
        style: CustomTextTheme.heading1(color: lightColorPalette.black),
      ),
    ).paddingOnly(left: 16.w);
  }

  Widget titleTextWidget({required String title}) {
    return AppTextWidget(
      text: title,
      style: CustomTextTheme.normalTextWithWeight600(
          color: lightColorPalette.black),
    );
  }

  Widget subTitleTextWidget({required String subTitle}) {
    return AppTextWidget(
      text: subTitle,
      style: CustomTextTheme.bottomTabs(color: lightColorPalette.grey),
    );
  }

  Widget bottomViewWidget({required Color? color}) {
    return Container(
      height: 1,
      width: 1.sw,
      color: color,
    );
  }

  Widget deviceNameTextFieldWidget() {
    return commonTextFieldWidget(
      controller: TextEditingController(),
      title: CommonString.deviceName.tr,
      hint: CommonString.devicenameplaceholder,
      focusNode: FocusNode(),
    );
  }

  Widget deviceIdTextFieldWidget() {
    return commonTextFieldWidget(
      controller: TextEditingController(),
      title: CommonString.deviceId.tr,
      hint: CommonString.deviceidplaceholder,
      focusNode: FocusNode(),
    );
  }

  Widget cancelButtonWidget() {
    return commonButtonWithBorder(
        onPress: () {
          Get.back();
        },
        commonButtonBottonText: CommonString.cancel.tr,
        bgColor: lightColorPalette.transparentColor,
        textColor: lightColorPalette.black);
  }

  Widget addButtonWidget() {
    return commonButtonWithBorder(
        onPress: () {
          Get.back();
        },
        commonButtonBottonText: CommonString.save.tr);
  }

  Widget addDeviceTextWidget(String title) {
    return AppTextWidget(
      text: title,
      style: CustomTextTheme.heading2(color: lightColorPalette.black),
    );
  }

  addDeviceNetwork({required String title}) {
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
                        addDeviceTextWidget(title),
                        const SizedBox(height: 15),
                        deviceNameTextFieldWidget(),
                        const SizedBox(height: 15),
                        deviceIdTextFieldWidget(),
                        SizedBox(height: 20.h),
                        //Buttons
                        Row(
                          children: [
                            Expanded(
                              child: cancelButtonWidget(),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: addButtonWidget(),
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
