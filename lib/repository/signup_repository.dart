import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signupWithEmailAndLink(String username, String email, String password) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    await _firestore.collection('users').doc(credential.user?.uid).set({
      'name' : username,
      'email' : email,
      'loggedIn' : true,
      'uid' : credential.user?.uid,
    });

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("name", username);
    preferences.setString("email", email);
    preferences.setString("uid", credential.user!.uid);
    preferences.setBool("loggedIn", true);
  }
}