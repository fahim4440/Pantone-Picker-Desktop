import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signupWithEmailAndLink(String username, String companyName, String email, String password) async {
    UserCredential credential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

    await _firestore.collection('users').doc(credential.user?.uid).set({
      'name' : username,
      'email' : email,
      'loggedIn' : false,
      'uid' : credential.user?.uid,
      'companyName' : companyName,
      'isEmailVerified' : credential.user?.emailVerified,
    });

    // Send email verification
    User? user = credential.user;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
      print('Verification email sent.');
    }

    await _firebaseAuth.signOut();
  }
}