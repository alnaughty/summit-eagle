import 'dart:async';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:summiteagle/globals/custom_toast.dart';
import 'package:summiteagle/services/data_cacher.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CustomToast _toastify = CustomToast();
  final DataCacher _cacher = DataCacher.instance;
  Future<User?> updateUser(User user) async {
    // user.updateDisplayName("displayName");
    // // user.upda
    // user.updatePhoneNumber(PhoneAuthCredential());
  }

  Future<User?> create(context,
      {required String email,
      required String password,
      required String fname,
      required String lname,
      required bool isRemembered}) async {
    try {
      UserCredential creds = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String displayName = fname + " " + lname;
      creds.user!.updateDisplayName(displayName);
      if (isRemembered) {
        _cacher.saveCredentials(
          email: email,
          password: password,
        );
      }
      // return await signIn(email: creds.user!.email!, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _toastify.showToast(
          context,
          msg: "User not found",
        );
      } else if (e.code == 'wrong-password') {
        _toastify.showToast(
          context,
          msg: "Incorrect password",
        );
      } else if (e.code == "email-already-in-use") {
        _toastify.showToast(
          context,
          msg: "Email already used",
        );
      } else if (e.code == "invalid-email") {
        _toastify.showToast(
          context,
          msg: "Invalid email format",
        );
      } else if (e.code == "weak-password") {
        _toastify.showToast(
          context,
          msg: "Password too weak",
        );
      }
      return null;
    } on SocketException {
      _toastify.showToast(
        context,
        msg: "No internet connection",
      );
      return null;
    } on HttpException {
      _toastify.showToast(
        context,
        msg: "An unexpected error has occured while processing your request",
      );
      return null;
    } on FormatException {
      _toastify.showToast(
        context,
        msg: "Format Error",
      );
      return null;
    } on TimeoutException {
      _toastify.showToast(
        context,
        msg: "Connection timeout",
      );
      Fluttertoast.showToast(msg: "Pas de connexion Internet : timeout");
      return null;
    }
  }

  Future<User?> signIn(context,
      {required String email,
      required String password,
      required bool isRememberd}) async {
    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );
      final authResult = await _auth.signInWithCredential(credential);
      final User? firebaseUser = authResult.user;
      if (isRememberd) {
        _cacher.saveCredentials(
          email: email,
          password: password,
        );
      }
      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _toastify.showToast(
          context,
          msg: "User not found",
        );
      } else if (e.code == 'wrong-password') {
        _toastify.showToast(
          context,
          msg: "Incorrect password",
        );
      } else if (e.code == "email-already-in-use") {
        _toastify.showToast(
          context,
          msg: "Email already used",
        );
      } else if (e.code == "invalid-email") {
        _toastify.showToast(
          context,
          msg: "Invalid email format",
        );
      } else if (e.code == "weak-password") {
        _toastify.showToast(
          context,
          msg: "Password too weak",
        );
      }
      return null;
    } on SocketException {
      _toastify.showToast(
        context,
        msg: "No internet connection",
      );
      return null;
    } on HttpException {
      _toastify.showToast(
        context,
        msg: "An unexpected error has occured while processing your request",
      );
      return null;
    } on FormatException {
      _toastify.showToast(
        context,
        msg: "Format Error",
      );
      return null;
    } on TimeoutException {
      _toastify.showToast(
        context,
        msg: "Connection timeout",
      );
      Fluttertoast.showToast(msg: "Pas de connexion Internet : timeout");
      return null;
    }
  }
}
