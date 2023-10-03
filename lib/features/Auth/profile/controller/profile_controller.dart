
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_lighting/Core/Firebase/User.dart';
import 'package:get/get.dart';

import '../../../../Core/storage/local_storage.dart';
import '../../../../Core/utils/Routes.dart';
import '../provider/profile_provider.dart';


class ProfileController extends GetxController {
  ProfileProvider profileProvider = ProfileProvider();
  RxString name = "".obs;
  RxString surname = "".obs;
  RxString useremail = "".obs;

  void onInit() {
    getProfile();
    super.onInit();
  }

  getProfile() async {
    String email = Prefs.read(Prefs.email);
    QuerySnapshot? response = await profileProvider.getProfile(email);
    if (response != null) {
      final data = User.fromJson(response?.docs.first.data());
      name.value = data.username ?? "";
      surname.value = data.surname ?? "";
      useremail.value = data.email ?? "";
    }
  }

  logout() async {
    await Prefs.erase();
    await profileProvider.signOut();
    Get.offAllNamed(MyRoutes.root);
  }
}
