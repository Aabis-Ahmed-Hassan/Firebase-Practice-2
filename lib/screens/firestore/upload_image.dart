import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_practice_code/components/my_button.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadImageonFirestore extends StatefulWidget {
  UploadImageonFirestore({super.key});

  @override
  State<UploadImageonFirestore> createState() => _UploadImageonFirestoreState();
}

class _UploadImageonFirestoreState extends State<UploadImageonFirestore> {
  File? pickedImage;

  bool loading = false;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image to Firestore'),
        backgroundColor: AppColors.defaultColor,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              print('tapped');
              var myImage =
                  await ImagePicker().pickImage(source: ImageSource.camera);

              if (myImage != null) {
                setState(() {
                  pickedImage = File(myImage.path);
                });
              } else {
                print('else statement');
              }
            },
            child: Text('Pick Image'),
          ),
          pickedImage == null
              ? Text('No image is selected')
              : Image.file(height: 250, pickedImage!),
          InkWell(
            onTap: () {
              setState(() {
                pickedImage = null;
              });
            },
            child: Container(
              height: 50,
              color: Colors.green,
              child: Center(
                child: Text(
                  'Reset Image',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MyButton(
              title: 'Upload on Firebase',
              onTap: () async {
                setState(() {
                  loading = true;
                });

                firebase_storage.Reference ref =
                    firebase_storage.FirebaseStorage.instance.ref(
                  '/my_folder/' +
                      DateTime.now().millisecondsSinceEpoch.toString(),
                );
                firebase_storage.UploadTask upload = ref.putFile(
                  pickedImage!,
                );

                await Future.value(upload).then((value) async {
                  var uploadFileUrl = await ref.getDownloadURL();

                  var dbRef = FirebaseDatabase.instance.ref('My File Ref');

                  dbRef
                      .child(DateTime.now().millisecondsSinceEpoch.toString())
                      .set(
                    {
                      'title': 'aabis image',
                      'image': uploadFileUrl.toString(),
                      'id': DateTime.now().millisecondsSinceEpoch.toString(),
                    },
                  );
                  Utils.showToastMessage('Uploaded successfully');

                  setState(() {
                    loading = false;
                  });
                }).onError((error, stackTrace) {
                  Utils.showToastMessage(error.toString());
                  setState(() {
                    loading = false;
                  });
                });

                // var firebasefirestore =
                //     FirebaseFirestore.instance.collection('collectionPath');
                // String id = DateTime.now().millisecondsSinceEpoch.toString();
                // firebasefirestore
                //     .doc(id)
                //     .set({'image': uploadFileUrl, 'id': id}).then((value) {
                //   Utils.showToastMessage('Uploaded Successfully');
                //   print('image uploaded on firestore successfully');
                //   setState(() {
                //     loading = false;
                //   });
                // }).onError((error, stackTrace) {
                //   Utils.showToastMessage(error.toString());
                //   print('image upload on firestore failed');
                //
                //   setState(() {
                //     loading = false;
                //   });
                // });
              },
              loading: loading),
        ],
      ),
    );
  }
}
