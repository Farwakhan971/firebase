import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_impl/auth/Login_screen.dart';
import 'package:firebase_impl/round_button.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';
class Signup_screen extends StatefulWidget {
  const Signup_screen({super.key});

  @override
  State<Signup_screen> createState() => _Signup_screenState();
}

class _Signup_screenState extends State<Signup_screen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  void Signup(){
    setState(() {
      loading = true;
    });
    if(_formkey.currentState!.validate()){
      _auth.createUserWithEmailAndPassword(
          email: emailcontroller.text.toString(),
          password: passwordcontroller.text.toString()).then((value) => {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> Login_screen()))
      }).onError((error, stackTrace){
        Utils().toastMessage(error.toString());
        setState(() {
          loading = false;
        });
        return {};
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.teal,
        title: Center(
          child: Text('Signup Screen', style: TextStyle(color: Colors.white),),
        ),
      ),
      body: Form(
        key: _formkey,
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailcontroller,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email'
                ),
                validator: (value){
                  if(value!.isEmpty)
                    return 'Please Enter your Email';
                  else{
                    return null;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextFormField(
                controller: passwordcontroller,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.lock),

                    hintText: 'Password'
                ),
                validator: (value){
                  if(value!.isEmpty)
                    return 'Please Enter your Password';
                  else{
                    return null;
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Roundbutton(
                loading: loading,
                  title: 'Sign up',
                  ontap: (){
                    Signup();
                  }),
            ),
            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login_screen()));
            }, child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont Have an Account? '),
                Text('Login'),
              ],
            ),
            )
          ],
        ),),
    );
  }
}
