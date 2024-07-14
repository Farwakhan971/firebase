import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
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
  final databaseref = FirebaseDatabase.instance.ref('Posts');
  final searchcotroller = TextEditingController();
  final editcotroller = TextEditingController();
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
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextFormField(
              onChanged: (value) {
                setState(() {});
              },
              controller: searchcotroller,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseref,
              itemBuilder: (context, snapshot, animation, index) {
                print(snapshot.value);
                String? title = snapshot.child('title').value?.toString();
                String? id = snapshot.key;
                if (title == null || title.isEmpty) {
                  title = 'No Title';
                }
                if (searchcotroller.text.isEmpty) {
                  return ListTile(
                    title: Text(title),
                    subtitle: Text(id.toString()),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          onTap: () {
                            Future.delayed(Duration.zero, () => ShowEditdialog(title!, id.toString()));
                          },
                          value: 1,
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                          ),
                        ),
                        PopupMenuItem(
                          onTap: () {
                            databaseref.child(id.toString()).remove().then(
                                    (value) => Utils().toastMessage('Post Deleted Successfully'));
                          },
                          value: 2,
                          child: ListTile(
                            leading: Icon(Icons.delete),
                            title: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (title.toLowerCase().contains(searchcotroller.text.toLowerCase().toString())) {
                  return ListTile(
                    title: Text(title),
                  );
                } else {
                  return Container();
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostsScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> ShowEditdialog(String title, String id) async {
    editcotroller.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            child: TextField(
              controller: editcotroller,
              decoration: InputDecoration(hintText: 'Edit here'),
            ),
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
                databaseref.child(id).update({
                  'title': editcotroller.text
                }).then((value) {
                  Navigator.pop(context);
                  Utils().toastMessage('Post Updated Successfully');
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
