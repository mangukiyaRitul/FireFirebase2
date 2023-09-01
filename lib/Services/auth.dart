import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  // make a instance of auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //signIn anonymous
  Future<User?> signInAnonymous() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      // debugPrint('result : $result : ${result.runtimeType}');
      // debugPrint('user : $user : ${user.runtimeType}');
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException signInAnonymously Error : $e');
      return null;
    } catch (e) {
      debugPrint('FirebaseAuth signInAnonymously CatchError : $e');
      return null;
    }
  }

  //  signIn with email & password

  Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      debugPrint('eMail : $email');
      debugPrint('Password : $password');
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      debugPrint("SignIn result : $result");
      debugPrint("SignIn User : $user");
      return user;
    } on FirebaseAuthException catch (e) {
      debugPrint("email : ${e.email}");
      debugPrint("plugIn : ${e.plugin}");
      debugPrint("code : ${e.code}");
      debugPrint("Credential : ${e.credential}");
      Fluttertoast.showToast(msg: "${e.code}");
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: "${e}");
      return null;
    }
  }

  // register with email & password

  Future<User?> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "${e.code}");
      return null;
    } catch (e) {
      Fluttertoast.showToast(msg: "${e}");
      return null;
    }
  }

  //signOut

  Future signOut() async {
      await _auth.signOut();
      return await googleSignIn.signOut();
  }
}