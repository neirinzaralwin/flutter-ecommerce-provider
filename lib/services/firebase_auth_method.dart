import 'package:ecommerce_app/screens/login/verfity_otp_page.dart';
import 'package:ecommerce_app/utils/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(this._auth);

  // PHONE SIGN IN
  Future<void> phoneSignIn(
    BuildContext context,
    String phoneNumber,
  ) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (e) {
        showSnackBar(context, e.message!);
      },
      codeSent: ((String verificationId, int? resendToken) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerifyOTPPage(
              verificationId: verificationId,
              auth: _auth,
              phoneNumber: phoneNumber,
            ),
          ),
        );
      }),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }
}
