// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_practice_code/components/my_button.dart';
// import 'package:firebase_practice_code/constants/app_colors.dart';
// import 'package:firebase_practice_code/screens/firestore/firestore_screen.dart';
// import 'package:firebase_practice_code/utils/utils.dart';
// import 'package:flutter/material.dart';
//
// class AddFirestoreData extends StatefulWidget {
//   AddFirestoreData({super.key});
//
//   @override
//   State<AddFirestoreData> createState() => _AddFirestoreDataState();
// }
//
// class _AddFirestoreDataState extends State<AddFirestoreData> {
//   final _postController = TextEditingController();
//
//   @override
//   final _fbfs = FirebaseFirestore.instance.collection('My Collection');
//
//   bool loading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Add Firestore Data',
//         ),
//         backgroundColor: AppColors.defaultColor,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(height: 15),
//             TextFormField(
//               maxLines: 3,
//               controller: _postController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "What's in your mind?",
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             MyButton(
//                 title: 'Add Data',
//                 onTap: () {
//                   setState(() {
//                     loading = true;
//                   });
//                   String id = DateTime.now().millisecondsSinceEpoch.toString();
//                   _fbfs.doc(id).set({
//                     'title': _postController.text.toString(),
//                     'id': id,
//                     'time': DateTime.now().hour.toString() +
//                         ':' +
//                         DateTime.now().minute.toString()
//                   }).then((value) {
//                     Utils.showToastMessage('Data Added Successfully');
//
//                     setState(() {
//                       loading = false;
//                     });
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => FirestoreScreen(),
//                       ),
//                     );
//                   }).onError((error, stackTrace) {
//                     Utils.showToastMessage(error.toString());
//                     setState(() {
//                       loading = false;
//                     });
//                   });
//                 },
//                 loading: loading),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice_code/components/my_button.dart';
import 'package:firebase_practice_code/screens/firestore/firestore_screen.dart';
import 'package:firebase_practice_code/utils/utils.dart';
import 'package:flutter/material.dart';

class AddFirestoreData extends StatefulWidget {
  AddFirestoreData({super.key});

  @override
  State<AddFirestoreData> createState() => _AddFirestoreDataState();
}

class _AddFirestoreDataState extends State<AddFirestoreData> {
  TextEditingController postController = TextEditingController();

  bool loading = false;
  var addDataToFirestore =
      FirebaseFirestore.instance.collection('My Collection');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Add Firebase Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: postController,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "What's in your mind?",
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MyButton(
                title: 'Add Data',
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  addDataToFirestore.doc(id).set(
                    {
                      'title': postController.text.toString(),
                      'time': DateTime.now().hour.toString() +
                          ':' +
                          DateTime.now().minute.toString(),
                      'id': id,
                    },
                  ).then(
                    (value) {
                      Utils.showToastMessage('Post Added Successfully');
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirestoreScreen(),
                        ),
                      );
                    },
                  ).onError((error, stackTrace) {
                    Utils.showToastMessage(error.toString());
                    setState(() {
                      loading = false;
                    });
                  });
                },
                loading: false),
          ],
        ),
      ),
    );
  }
}
