import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class SigninRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> signInWithEmailAndPassword(String email, String password) async {
    UserModel user = await _checkUserLoggedIntoAnotherDevice(email);
    if(user.loggedIn) {
      throw("Already logged into another device. Please sign out first");
    } else {
      UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      User? userFromFirebase = credential.user;
      if (userFromFirebase!.emailVerified) {
        print('User signed in: ${user.email}');
        await _setLoggedInToDatabase(user.uid);
        user = UserModel(uid: user.uid, email: user.email, name: user.name, loggedIn: true, companyName: user.companyName, isEmailVerified: true);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("name", user.name);
        preferences.setString("email", user.email);
        preferences.setString("uid", user.uid);
        preferences.setBool("loggedIn", true);
        preferences.setString("companyName", user.companyName);
        preferences.setBool("isEmailVerified", user.isEmailVerified);
        return user;
      } else { // Sign out the user if email is not verified
        return user;
      }
    }
  }

  Future<void> resendEmail(String email, String password) async {
    UserCredential credential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    User? user = credential.user;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('Verification email resent.');
    }
    _firebaseAuth.signOut();
  }

  Future<void> _setLoggedInToDatabase(String uid) async {
    await _firestore.collection('users').doc(uid).update({
      'loggedIn' : true,
      'isEmailVerified' : true,
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