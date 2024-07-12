import 'package:firebase_impl/firebase_Services/splash_services.dart';
import 'package:flutter/material.dart';

import 'firebase_Services/splash_services.dart';
class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  SplashServices splashservices = SplashServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashservices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Firebase', style: TextStyle(color: Colors.teal, fontSize: 24),),
      ),
    );
  }
}
