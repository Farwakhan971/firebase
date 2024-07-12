import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_impl/round_button.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';

class AddPostsScreen extends StatefulWidget {
  const AddPostsScreen({super.key});

  @override
  State<AddPostsScreen> createState() => _AddPostsScreenState();
}

class _AddPostsScreenState extends State<AddPostsScreen> {
  final databaseRef = FirebaseDatabase.instance.ref('Posts');
  final postController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Add Post', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: postController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Add post',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 40),
          Roundbutton(
            loading: loading,
            title: 'Add',
            ontap: () {
              setState(() {
                loading = true;
              });
              databaseRef.child('1').set({
                'title': postController.text.toString()
              }).then((value) {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage('Post Added');
              }).onError((error, stackTrace) {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage(error.toString());
              });
            },
          ),
        ],
      ),
    );
  }
}
