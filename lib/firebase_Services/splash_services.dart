import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/auth/Login_screen.dart';
import 'package:firebase_impl/firestore/firestore_list_Screen.dart';
import 'package:firebase_impl/post_Screen.dart';
import 'package:firebase_impl/upload_image.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context){
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if(user!= null){
      Timer(Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context) => UploadImage())),
      );
    }
    else{
      Timer(Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context) => Login_screen())));}

  }
}