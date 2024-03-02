import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_practice_code/components/my_button.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/screens/home_screen.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  bool loading = false;
  TextEditingController addPostController = TextEditingController();

  final databaseRef = FirebaseDatabase.instance.ref('Node 1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Post',
          style: TextStyle(
            color: AppColors.secondaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 15,
        ),
        child: Column(
          children: [
            SizedBox(height: 25),
            TextFormField(
              controller: addPostController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "What's in your mind?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 25),
            MyButton(
              title: 'Add',
              loading: loading,
              onTap: () {
                setState(() {
                  loading = true;
                });

                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set(
                  {
                    'id': id,
                    'title': addPostController.text.toString(),
                  },
                ).then(
                  (value) {
                    Utils.showToastMessage('Post Added Successfully');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                    setState(
                      () {
                        loading = false;
                      },
                    );
                  },
                ).onError(
                  (error, stackTrace) {
                    Utils.showToastMessage(error.toString());

                    setState(() {
                      loading = false;
                    });
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
