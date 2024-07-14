import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_impl/utils/round_button.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';

class Addfirestorescreen extends StatefulWidget {
  const Addfirestorescreen({super.key});

  @override
  State<Addfirestorescreen> createState() => _AddfirestorescreenState();
}

class _AddfirestorescreenState extends State<Addfirestorescreen> {
  final firestore = FirebaseFirestore.instance.collection('Posts');
  final postController = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Add Firestore data', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              controller: postController,
              maxLines: 3,
              decoration: const InputDecoration(
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
              String id = DateTime.now().millisecondsSinceEpoch.toString(); // Generate a new document ID
              firestore.doc(id).set({
                'title': postController.text.toString(),
                'id': id
              }).then((value) {
                setState(() {
                  loading = false;
                });
                Utils().toastMessage('Stored in Firestore');
              }).catchError((error) {
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
