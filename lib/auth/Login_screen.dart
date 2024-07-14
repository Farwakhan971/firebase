import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/auth/Loginwithphone.dart';
import 'package:firebase_impl/auth/signup_screen.dart';
import 'package:firebase_impl/post_Screen.dart';
import 'package:firebase_impl/utils/round_button.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class Login_screen extends StatefulWidget {
  const Login_screen({super.key});

  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  void Login(){
    setState(() {
      loading = true;
    });
    _auth.signInWithEmailAndPassword(
        email: emailcontroller.text.toString(),
        password: passwordcontroller.text.toString()).then((value) {
          Utils().toastMessage(value.user!.email.toString());
          Navigator.push(context, MaterialPageRoute(builder: (context) => Post_screen()));
          setState(() {
            loading = false;
          });
    }
    ).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          title: Center(
              child: Text('Login Screen', style: TextStyle(color: Colors.white),),
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
                    title: 'Login',
                    ontap: (){
                if(_formkey.currentState!.validate()){
                     Login();
                }}),),
              TextButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => Signup_screen()));
              }, child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dont Have an Account? '),
                      Text('Sign Up'),
                    ],
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> loginwithphone()));
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: Colors.teal)
                    ),
                    child: Center(child: Text('Login with phone', style: TextStyle(color: Colors.black),)),
                  ),
                ),
              )
            ],
          ),),
      ),
    );
  }
}
