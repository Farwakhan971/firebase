import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/auth/verifycodescreen.dart';
import 'package:firebase_impl/round_button.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';
class loginwithphone extends StatefulWidget {
  const loginwithphone({super.key});

  @override
  State<loginwithphone> createState() => _loginwithphoneState();
}

class _loginwithphoneState extends State<loginwithphone> {
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
  final phoneverifycontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Phone'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: phoneverifycontroller,
              decoration: InputDecoration(
                hintText: '(+92) 3156943990'
              ),

            ),
          ),
          Roundbutton(
              title: 'Login',
              loading: loading,
              ontap: (){
                setState(() {
                  loading = true;
                });
             auth.verifyPhoneNumber(
               phoneNumber: phoneverifycontroller.text,
                 verificationCompleted: (_){},
                 verificationFailed: (e){
                 Utils().toastMessage(e.toString());
                 setState(() {
                   loading = false;
                 });
                 },
                 codeSent: (String verificationId, int? token){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyCodeScreen(verificationId: verificationId,)));
                     setState(() {
                       loading = false;
                     });
                 },
                 codeAutoRetrievalTimeout: (e){
                 Utils().toastMessage(e.toString());
                 setState(() {
                   loading = false;
                 });
                 });
              })

        ],
      ),
    );
  }
}
