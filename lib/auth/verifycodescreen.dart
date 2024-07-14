import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/post_Screen.dart';
import 'package:flutter/material.dart';

import '../utils/round_button.dart';
import '../utils/utils.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationId;
  const VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final digitVerifyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: digitVerifyController,
              decoration: InputDecoration(
                hintText: '6 digit code',
              ),
            ),
          ),
          Roundbutton(
            title: 'Verify',
            loading: loading,
            ontap: () async {
              setState(() {
                loading = true;
              });
              final credentials = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: digitVerifyController.text.toString(),
              );
              try {
                await auth.signInWithCredential(credentials);
                Navigator.push(context, MaterialPageRoute(builder: (context) => Post_screen()));
              } catch (e) {
                Utils().toastMessage('Verification failed: $e');
              } finally {
                setState(() {
                  loading = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
