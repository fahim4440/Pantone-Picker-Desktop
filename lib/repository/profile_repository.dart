import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserModel> getUserFromSharedPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString("uid")!;
    String email = preferences.getString("email")!;
    String name = preferences.getString("name")!;
    bool loggedIn = preferences.getBool("loggedIn")!;
    return UserModel(uid: uid, email: email, name: name, loggedIn: loggedIn);
  }

  Future<void> signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString("uid")!;
    await _firestore.collection('users').doc(uid).update({
      'loggedIn' : false,
    });
    await _firebaseAuth.signOut();
    preferences.setString("email", "");
    preferences.setString("name", "");
    preferences.setString("uid", "");
    preferences.setBool("loggedIn", false);
  }
}