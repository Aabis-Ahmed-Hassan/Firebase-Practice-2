import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/screens/add_post.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  FirebaseAuth _fbAuth = FirebaseAuth.instance;

  final ref = FirebaseDatabase.instance.ref('Node 1');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.defaultColor,
        automaticallyImplyLeading: false,
        title: Text(
          'HomeScreen',
          style: TextStyle(color: AppColors.secondaryColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _fbAuth.signOut().then((value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              }).onError((error, stackTrace) {
                Utils.showToastMessage(
                  error.toString(),
                );
              });
            },
            icon: Icon(
              Icons.logout_outlined,
              color: AppColors.secondaryColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          // Expanded(
          //   child: FirebaseAnimatedList(
          //     query: ref,
          //     itemBuilder: (context, snapshot, animation, index) {
          //       return Card(
          //         child: Container(
          //           padding: EdgeInsets.symmetric(
          //             vertical: 15,
          //           ),
          //           child: Column(
          //             children: [
          //               Text(snapshot.child('id').value.toString()),
          //               Text(snapshot.child('title').value.toString()),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),

          Expanded(
            child: FirebaseAnimatedList(
                defaultChild: Center(
                  child: CircularProgressIndicator(),
                ),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image(
                        image: NetworkImage(
                            'https://media.licdn.com/dms/image/D4E03AQE0jZ3uX-2bhg/profile-displayphoto-shrink_200_200/0/1702916322665?e=2147483647&v=beta&t=XhnVr6bE9Sn99Vkh5gzVEQG1iAf9HdVRU4Y-Y_tGLOE'),
                      ),
                    ),
                    title: Text(
                      snapshot.child('title').value.toString(),
                    ),
                    subtitle: Text(
                      snapshot.child('id').value.toString(),
                    ),
                  );
                }),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddPost(),
            ),
          );
        },
        backgroundColor: AppColors.defaultColor,
        child: Icon(
          Icons.add,
          size: 28,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }
}
