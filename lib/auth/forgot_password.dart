import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/utils/round_button.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';
class Forgot_Password extends StatefulWidget {
  const Forgot_Password({super.key});

  @override
  State<Forgot_Password> createState() => _Forgot_PasswordState();
}

class _Forgot_PasswordState extends State<Forgot_Password> {
  final emailcontroller = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              controller: emailcontroller,
              decoration: InputDecoration(
                hintText: 'Email'
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Roundbutton(
              title: 'Forgot Password',
              ontap: (){
               auth.sendPasswordResetEmail(
                   email: emailcontroller.toString()
               ).then((value) => {
                 Utils().toastMessage('Message is sent on the email for recovery of password. check it out')
               }).onError((error, stackTrace) => {
                 Utils().toastMessage(error.toString()),
               });
              })

        ],
      ),
    );
  }
}
