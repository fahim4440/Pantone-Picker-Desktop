import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class SigninRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    UserModel user = await _checkUserLoggedIntoAnotherDevice(email);
    if(user.loggedIn) {
      throw("Already logged into another device. Please sign out first");
    } else {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _setLoggedInToDatabase(user.uid);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("email", user.email);
      preferences.setString("name", user.name);
      preferences.setString("uid", user.uid);
      preferences.setBool("loggedIn", true);
    }
  }

  Future<void> _setLoggedInToDatabase(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'loggedIn' : true,
    });
  }
  
  Future<UserModel> _checkUserLoggedIntoAnotherDevice(String email) async {
    QuerySnapshot<Map<String, dynamic>> users = await _firestore.collection('users').where("email", isEqualTo: email).get();
    if (users.docs.isEmpty) {
      throw("Please signup first!");
    }
    UserModel user = UserModel.fromMap(users.docs[0].data());
    return user;
  }
}