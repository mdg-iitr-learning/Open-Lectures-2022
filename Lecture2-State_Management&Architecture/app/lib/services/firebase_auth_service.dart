import 'package:app/utils/error_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  User get currentUser => _firebaseAuth.currentUser!;

  // Sign In with email and password
  Future<UserCredential?> signIn(String email, String password) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw signInErrorCodes[e.code] ?? 'Database Error Occured!';
    } catch (e) {
      throw '${e.toString()} Error Occured!';
    }
  }

  // Sign Up using email address
  Future<UserCredential?> signUp(
      String name, String email, String password) async {
    try {
      var _user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _firebaseFirestore
          .collection('Users')
          .doc(_user.user!.email)
          .set({'name': name, 'phone': 'Phone', 'enrollment': 'Enrollment'})
          .then((value) => debugPrint('User Created : ${_user.user!.email}'))
          .catchError((e) => debugPrint('Database Error!'));
      return _user;
    } on FirebaseAuthException catch (e) {
      debugPrint(
          signUpErrorCodes[e.code] ?? 'Firebase ${e.code} Error Occured!');
    } catch (e) {
      debugPrint('${e.toString()} Error Occured!');
    }
  }

  // Sign Out
  Future<String> signOut() async {
    await _firebaseAuth.signOut();
    return 'Signed Out Successfully';
  }
}
