import 'package:flutter_smart_lighting/features/Login/binding/login_binding.dart';
import 'package:flutter_smart_lighting/features/bottom_tabs/binding/bottom_tab_binding.dart';
import 'package:flutter_smart_lighting/features/bottom_tabs/screen/bottom_tab_screen.dart';
import 'package:flutter_smart_lighting/features/dashboard/binding/dashboard_binding.dart';
import 'package:flutter_smart_lighting/features/dashboard/screen/dashboard_screen.dart';
import 'package:flutter_smart_lighting/features/wifi_login/binding/wifi_binding.dart';
import 'package:flutter_smart_lighting/features/wifi_login/screen/wifi_login_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_smart_lighting/Core/utils/common_string.dart';
import 'package:flutter_smart_lighting/features/Login/screen/login_screen.dart';
import '../../features/signup/binding/sign_up_binding.dart';
import '../../features/signup/screen/sign_up_screen.dart';

class MyRoutes {
  static const String root = "/";
  static String signUpscreen = "/signupscreen";
  static String dashboardscreen = "/dashboardscreen";

  static String wifiloginscreen = "/wifiloginscreen";
  static String bottomtabscreen = "/bottomtabscreen";
}
List<GetPage> appPages() => [
  GetPage(
    name: MyRoutes.root,
    page: () =>  LoginScreen(),
    fullscreenDialog: true,
    binding: LoginBinding(),
    transition: CommonString.transition,

  ),
  GetPage(
    name: MyRoutes.signUpscreen,
    page: () =>  SignUpScreen(),
    fullscreenDialog: true,
    binding: SignUpBinding(),
    transition: CommonString.transition,

  ),
  GetPage(
    name: MyRoutes.wifiloginscreen,
    page: () =>  WifiLoginScreen(),
    fullscreenDialog: true,
    binding: WifiLoginBinding(),
    transition: CommonString.transition,

  ),

  GetPage(
    name: MyRoutes.bottomtabscreen,
    page: () =>  BottomTabScreen(),
    fullscreenDialog: true,
    binding: BottomTabBinding(),
    transition: CommonString.transition,

  ),
  GetPage(
    name: MyRoutes.dashboardscreen,
    page: () =>  DashboardScreen(),
    fullscreenDialog: true,
    binding: DashboardBinding(),
    transition: CommonString.transition,

  ),
];

