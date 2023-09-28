import 'package:firebase_auth/firebase_auth.dart';

import '../../../Core/Firebase/firebase.dart';

class SignUpProvider {
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String username,
    required String surname,
  }) async {
    UserCredential? response = await AuthenticationHelper().signUp(
        email: email, password: password, username: username, surname: surname);
    return response;
  }
}
