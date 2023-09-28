import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';

import '../../../Core/Firebase/firebase.dart';

class SignUpProvider {
  Future<UserCredential?> signUp(
      {required String email, required String password}) async {
    UserCredential? response =
        await AuthenticationHelper().signUp(email: email, password: password);
    return response;
  }
}
