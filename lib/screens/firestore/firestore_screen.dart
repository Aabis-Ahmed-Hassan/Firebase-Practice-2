// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_practice_code/constants/app_colors.dart';
// import 'package:firebase_practice_code/screens/auth/login_screen.dart';
// import 'package:firebase_practice_code/screens/firestore/add_firestore_data.dart';
// import 'package:firebase_practice_code/utils/utils.dart';
// import 'package:flutter/material.dart';
//
// class FirestoreScreen extends StatefulWidget {
//   const FirestoreScreen({super.key});
//
//   @override
//   State<FirestoreScreen> createState() => _FirestoreScreenState();
// }
//
// class _FirestoreScreenState extends State<FirestoreScreen> {
//   final fbfs =
//       FirebaseFirestore.instance.collection('My Collection').snapshots();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: Text(
//           'Firestore Screen',
//         ),
//         actions: [
//           InkWell(
//               onTap: () {
//                 FirebaseAuth.instance.signOut().then(
//                   (value) {
//                     Utils.showToastMessage('Logout Successfully');
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => LoginScreen(),
//                       ),
//                     );
//                   },
//                 ).onError((error, stackTrace) {
//                   Utils.showToastMessage(error.toString());
//                 });
//               },
//               child: Icon(
//                 Icons.logout,
//               )),
//           SizedBox(
//             width: 10,
//           ),
//         ],
//         backgroundColor: AppColors.defaultColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             StreamBuilder<QuerySnapshot>(
//               stream: fbfs,
//               builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     itemBuilder: (context, index) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return CircularProgressIndicator();
//                       } else if (snapshot.hasError) {
//                         return Text('An error occured');
//                       } else {
//                         return ListTile(
//                           title: Text(
//                             snapshot.data!.docs[index]['title'].toString(),
//                           ),
//                           subtitle: Text(
//                             snapshot.data!.docs[index]['time'].toString(),
//                           ),
//                         );
//                       }
//                     },
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: AppColors.defaultColor,
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => AddFirestoreData()));
//         },
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice_code/screens/firestore/add_firestore_data.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

class FirestoreScreen extends StatefulWidget {
  const FirestoreScreen({super.key});

  @override
  State<FirestoreScreen> createState() => _FirestoreScreenState();
}

class _FirestoreScreenState extends State<FirestoreScreen> {
  var firestoreInstance =
      FirebaseFirestore.instance.collection('My Collection').snapshots();

  TextEditingController controllerToUpdateData = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green, title: Text('Firestore Screen')),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestoreInstance,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            snapshot.data!.docs[index]['title'].toString(),
                          ),
                          subtitle: Text(
                            snapshot.data!.docs[index]['time'].toString(),
                          ),
                          trailing: PopupMenuButton(
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      String id = snapshot
                                          .data!.docs[index]['id']
                                          .toString();

                                      String title = snapshot
                                          .data!.docs[index]['title']
                                          .toString();
                                      print('tapped');

                                      update(title, id);
                                    },
                                    child: Text(
                                      'Update',
                                    ),
                                  ),
                                ),
                                PopupMenuItem(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.pop(context);

                                      String id = snapshot
                                          .data!.docs[index]['id']
                                          .toString();

                                      delete(id);
                                    },
                                    child: Text(
                                      'Delete',
                                    ),
                                  ),
                                ),
                              ];
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(
          Icons.add,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddFirestoreData(),
            ),
          );
        },
      ),
    );
  }

  Future<void> update(String title, String id) async {
    controllerToUpdateData.text = title;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Update',
          ),
          content: TextFormField(
            controller: controllerToUpdateData,
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
                FirebaseFirestore.instance
                    .collection('My Collection')
                    .doc(id)
                    .update({
                  'title': controllerToUpdateData.text.toString(),
                }).then((value) {
                  Navigator.pop(context);

                  Utils.showToastMessage('Updated');
                }).onError((error, stackTrace) {
                  Utils.showToastMessage(error.toString());
                  Navigator.pop(context);
                });
              },
              child: Text(
                'Update',
              ),
            )
          ],
        );
      },
    );
  }

  Future<void> delete(String id) async {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Are you sure to delete?'),
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
                  FirebaseFirestore.instance
                      .collection('My Collection')
                      .doc(id)
                      .delete()
                      .then(
                    (value) {
                      Navigator.pop(context);
                      Utils.showToastMessage('Deleted Successfully');
                    },
                  ).onError(
                    (error, stackTrace) {
                      Navigator.pop(context);

                      Utils.showToastMessage(
                        error.toString(),
                      );
                    },
                  );
                },
                child: Text(
                  'Delete',
                ),
              ),
            ],
          );
        });
  }
}
