import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_practice_code/constants/app_colors.dart';
import 'package:firebase_practice_code/screens/add_post.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

import 'auth/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth _fbAuth = FirebaseAuth.instance;

  var searchController = TextEditingController();
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
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          //fetching data from firebase with StreamBuilder
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
          //       Map<dynamic, dynamic> myMap =
          //           snapshot.data!.snapshot.value as dynamic;
          //
          //       List<dynamic> myList = [];
          //       myList.clear();
          //       myList = myMap.values.toList();
          //
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //           itemCount: snapshot.data!.snapshot.children.length,
          //           itemBuilder: (context, index) {
          //             return ListTile(
          //               title: Text(
          //                 myList[index]['title'].toString(),
          //               ),
          //               subtitle: Text(
          //                 myList[index]['id'].toString(),
          //               ),
          //             );
          //           },
          //         );
          //       } else {
          //         return CircularProgressIndicator();
          //       }
          //     },
          //   ),
          // ),

          ///////////////////////////////////////////////////
          ///////////////////////////////////////////////////
          ///////////////////////////////////////////////////
          ///////////////////////////////////////////////////
          ///////////////////////////////////////////////////

          //
          //
          //fetch data from firebase with FirebaseAnimatedList Widget
          Expanded(
            child: FirebaseAnimatedList(
                defaultChild: Center(
                  child: CircularProgressIndicator(),
                ),
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  String title = snapshot.child('title').value.toString();
                  if (searchController.text.isEmpty) {
                    return ListTile(
                      title: Text(
                        snapshot.child('title').value.toString(),
                      ),
                      subtitle: Text(
                        snapshot.child('id').value.toString(),
                      ),
                    );
                  } else if (title
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase())) {
                    return ListTile(
                      title: Text(
                        snapshot.child('title').value.toString(),
                      ),
                      subtitle: Text(
                        snapshot.child('id').value.toString(),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),

          Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  itemBuilder: (context, snapshot, animation, index) {
                    return ListTile(
                      title: Text(snapshot.child('title').value.toString()),
                      subtitle: Text(snapshot.child('id').value.toString()),
                    );
                  })),
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
