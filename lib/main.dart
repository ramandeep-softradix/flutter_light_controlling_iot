import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_lighting/Core/Firebase/firebase.dart';
import 'package:flutter_smart_lighting/Core/theme/app_color_palette.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'Core/storage/local_storage.dart';
import 'Core/utils/Routes.dart';

void main() async {
  await GetStorage.init();
  await FirebaseInit().onIint();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var token = Prefs.read(Prefs.token);
    String root = token == null ? MyRoutes.root : MyRoutes.bottomtabscreen;

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return ScreenUtilInit(
        designSize: Size(375, 812),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            getPages: appPages(),
            initialRoute: root,
            theme: ThemeData(primarySwatch: lightColorPalette.primaryBlack),
          );
        });
  }
}
