import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_smart_lighting/Core/Firebase/firebase.dart';

class ProfileProvider {
  Future<QuerySnapshot?> getProfile(String email) {
    var response = AuthenticationHelper().getProfile(userEmail: email);
    return response;
  }
  signOut(){
    AuthenticationHelper().signOut();
  }
}
