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
  var editController = TextEditingController();
  final ref = FirebaseDatabase.instance.ref('Node 1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.defaultColor,
        automaticallyImplyLeading: false,
        title: const Text(
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
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }).onError((error, stackTrace) {
                Utils.showToastMessage(
                  error.toString(),
                );
              });
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: AppColors.secondaryColor,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextFormField(
              controller: searchController,
              decoration: const InputDecoration(
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
              defaultChild: const Center(
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
                    trailing: PopupMenuButton(
                        icon: const Icon(Icons.menu),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);

                                  myDialogForUpdate(
                                      snapshot.child('title').value.toString(),
                                      snapshot.child('id').value.toString());
                                },
                                leading: Icon(
                                  Icons.edit,
                                ),
                                title: Text(
                                  'Edit',
                                ),
                              ),
                            ),
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                myDialogForDelete(
                                    snapshot.child('id').value.toString());
                              },
                              leading: Icon(
                                Icons.delete,
                              ),
                              title: Text(
                                'Delete',
                              ),
                            ))
                          ];
                        }),
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
                    trailing: PopupMenuButton(
                        icon: const Icon(Icons.menu),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context);

                                  myDialogForUpdate(
                                      snapshot.child('title').value.toString(),
                                      snapshot.child('id').value.toString());
                                },
                                leading: Icon(
                                  Icons.edit,
                                ),
                                title: Text(
                                  'Edit',
                                ),
                              ),
                            ),
                            PopupMenuItem(
                                child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                myDialogForDelete(
                                    snapshot.child('id').value.toString());
                              },
                              leading: Icon(
                                Icons.delete,
                              ),
                              title: Text(
                                'Delete',
                              ),
                            ))
                          ];
                        }),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPost(),
            ),
          );
        },
        backgroundColor: AppColors.defaultColor,
        child: const Icon(
          Icons.add,
          size: 28,
          color: AppColors.secondaryColor,
        ),
      ),
    );
  }

  Future<void> myDialogForUpdate(String title, String childName) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Do you want to update?'),
          content: TextFormField(
            controller: editController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
              ),
            ),
            TextButton(
              onPressed: () {
                ref.child(childName).update({
                  'title': editController.text.toString(),
                }).then((value) {
                  Navigator.pop(context);
                  Utils.showToastMessage('Post Updated Successfully');
                }).onError((error, stackTrace) {
                  Navigator.pop(context);
                  Utils.showToastMessage(error.toString());
                });
              },
              child: Text(
                'Update',
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> myDialogForDelete(String childName) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure to delete?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  ref.child(childName).remove().then((value) {
                    Navigator.pop(context);

                    Utils.showToastMessage('Post deleted successfully!');
                  }).onError((error, stackTrace) {
                    Navigator.pop(context);

                    Utils.showToastMessage(error.toString());
                  });
                },
                child: Text('Yes'),
              ),
            ],
          );
        });
  }
}
