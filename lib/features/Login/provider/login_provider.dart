import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';
import 'package:flutter_smart_lighting/Core/utils/Routes.dart';
import 'package:get/get.dart';

import '../../../Core/Firebase/firebase.dart';

class LoginProvider {
  Future<UserCredential?> login(
      {required String email, required String password}) async {
    UserCredential? response =
        await AuthenticationHelper().login(email: email, password: password);
    return response;
  }
}
