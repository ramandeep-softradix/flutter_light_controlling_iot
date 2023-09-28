import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_smart_lighting/Core/common_ui/snackbar/snackbar.dart';
import 'package:get/get.dart';

class FirebaseInit {
  Future<void> onIint() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }
}

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;

  get user => auth.currentUser;

  //SIGN UP METHOD
  Future<UserCredential?> signUp({
    required String email,
    required String password,
    required String username,
    required String surname,
  }) async {
    try {
      var response = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print(response);

      await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
        'uid': user.uid,
        'email': email,
        'username': username,
        'password': password,
        'role': 'user',
        'surname': surname,
      });

      return response;
    } on FirebaseAuthException catch (e) {
      snackbar(e.code);
    }
  }

  //SIGN IN METHOD
  Future<UserCredential?> login(
      {required String email, required String password}) async {
    try {
      var response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return response;
    } on FirebaseAuthException catch (e) {
      snackbar(e.code);
    }
  }

 Future<QuerySnapshot?> getProfile({required String userEmail}) async {
    final QuerySnapshot snap = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: userEmail)
        .get();
    return snap;
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await auth.signOut();
    print('signout');
  }
}
