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
    String companyName = preferences.getString("companyName")!;
    bool isEmailVerified = preferences.getBool("isEmailVerified")!;
    return UserModel(uid: uid, email: email, name: name, loggedIn: loggedIn, companyName: companyName, isEmailVerified: isEmailVerified);
  }

  Future<void> signout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String uid = preferences.getString("uid")!;
    await _firestore.collection('users').doc(uid).update({
      'loggedIn' : false,
    });
    await _firebaseAuth.signOut();
    preferences.remove("email");
    preferences.remove("name");
    preferences.remove("uid");
    preferences.remove("loggedIn");
    preferences.remove("companyName");
    preferences.remove("isEmailVerified");
  }
}