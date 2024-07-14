import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_impl/utils/round_button.dart';
import 'package:firebase_impl/utils/utils.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
class UploadImage extends StatefulWidget {
  const UploadImage({super.key});
  @override
  State<UploadImage> createState() => _UploadImageState();
}
class _UploadImageState extends State<UploadImage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('Posts');
  File? _image;
  final ImagePicker imagePicker = ImagePicker();

  Future getGalleryImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Utils().toastMessage('No image picked');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Image')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: InkWell(
              onTap: () {
                getGalleryImage();
              },
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(border: Border.all()),
                child: _image != null ? Image.file(_image!.absolute) : const Icon(Icons.image),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Roundbutton(
            title: 'Upload',
            ontap: () async {
              if (_image != null) {
                Reference ref = storage.ref().child('foldername/' + DateTime.now().millisecondsSinceEpoch.toString());
                UploadTask uploadTask = ref.putFile(_image!.absolute);

                await uploadTask.whenComplete(() async {
                  String newUrl = await ref.getDownloadURL();
                  await databaseRef.child('1').set({
                    'id': '1122',
                    'title': newUrl,
                  });
                  Utils().toastMessage('Uploaded Successfully');
                });
              } else {
                Utils().toastMessage('No image selected');
              }
            },
          ),
        ],
      ),
    );
  }
}
