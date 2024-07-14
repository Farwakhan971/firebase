import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_impl/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_impl/auth/Login_screen.dart';
import 'package:firebase_impl/utils/utils.dart';
class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});
  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}
class _FirestoreScreenState extends State<FirestoreScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection('Posts').snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection('Posts');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore screen'),
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
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
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: firestore,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                Utils().toastMessage('Some Error Occured');
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No Data Available'));
              }
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      // onTap:(){
                      //   ref.doc(snapshot.data!.docs[index]['id']).update({
                      //     'title': 'farwa khan'
                      //   }).then((value) {
                      //     Utils().toastMessage('Post updated');
                      //   }).onError((error, stackTrace) {
                      //     Utils().toastMessage(error.toString());
                      //   });
                      // },
                      onTap: ()
                        {
                          ref.doc(snapshot.data!.docs[index]['id'].toString()).delete();
                          },
                      title: Text(snapshot.data!.docs[index]['title'].toString()),
                      subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Addfirestorescreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
  Future<void> ShowEditdialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Edit here'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('Posts').doc(id).update({
                  'title': editController.text
                }).then((value) {
                  Utils().toastMessage('Post updated successfully');
                  Navigator.pop(context);
                }).catchError((error) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }
}
