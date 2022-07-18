import 'package:ecommerce_app/components/buttons.dart';
import 'package:ecommerce_app/utils/colors.dart';
import 'package:ecommerce_app/utils/show_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyOTPPage extends StatefulWidget {
  final verificationId;
  final FirebaseAuth auth;
  final String phoneNumber;
  const VerifyOTPPage(
      {Key? key,
      required this.verificationId,
      required this.auth,
      required this.phoneNumber})
      : super(key: key);

  @override
  State<VerifyOTPPage> createState() => _VerifyOTPPageState();
}

class _VerifyOTPPageState extends State<VerifyOTPPage> with CodeAutoFill {
  String codeValue = "";

  @override
  void codeUpdated() {
    print("Update code $code");
    setState(() {
      print("codeUpdated");
    });
  }

  @override
  void initState() {
    super.initState();
    listenOtp();
  }

  void signinwithPhone() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: codeValue);

    try {
      await widget.auth.signInWithCredential(credential);

      Navigator.pushReplacementNamed(context, 'bottombar');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        showSnackBar(context, 'Wrong code number!');
      }
    } catch (e) {
      showSnackBar(context, "Unkown Error Occured!");
    }
  }

  void listenOtp() async {
    await SmsAutoFill().unregisterListener();
    listenForCode();
    await SmsAutoFill().listenForCode;
    print("OTP listen Called");
  }

  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    print("unregisterListener");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .1),
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  color: Colors.black.withOpacity(.7),
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  wordSpacing: 4,
                ),
              ),
            ),
            Text('Verification code will be sent to ${widget.phoneNumber}'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do you want to '),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Edit Number ?',
                    style: TextStyle(
                        color: accentColor, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Center(
              child: PinFieldAutoFill(
                decoration: BoxLooseDecoration(
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  strokeWidth: 3,
                  strokeColorBuilder:
                      PinListenColorBuilder(Colors.black45, primaryColor),
                  bgColorBuilder:
                      PinListenColorBuilder(Colors.black45, Colors.black45),
                ),
                currentCode: codeValue,
                autoFocus: true,
                codeLength: 6,
                onCodeChanged: (code) {
                  print("onCodeChanged $code");
                  setState(() {
                    codeValue = code.toString();
                  });
                },
                onCodeSubmitted: (val) {
                  print("onCodeSubmitted $val");
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            glassButton(
                context, CupertinoIcons.arrow_right_square, 'Verify Code', () {
              print(codeValue);
              signinwithPhone();
            }),
            SizedBox(height: 10),
            glassButton(context, CupertinoIcons.text_bubble, 'Resend OTP', () {
              listenOtp();
            }),
          ],
        ),
      ),
    );
  }
}
