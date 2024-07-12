import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/add_post_screen.dart';
import 'package:firebase_impl/auth/Login_screen.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';
class Post_screen extends StatefulWidget {
  const Post_screen({super.key});

  @override
  State<Post_screen> createState() => _Post_screenState();
}

class _Post_screenState extends State<Post_screen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post screen'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login_screen())
                );
              }).catchError((error) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostsScreen()));
          },
          child: Icon(Icons.add),
          ),
    );
  }
}
