// import 'package:baigiamasis/modules/globals.dart';
// import 'package:baigiamasis/modules/update_property_details.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class ShowTenant extends StatelessWidget {
//   final document = FirebaseFirestore.instance.collection(firestoreTenant);
//   @override
//   Widget build(BuildContext context) {
//     countTotalPaidRent();
//     //String currentUser = FirebaseAuth.instance.currentUser.uid;
//     return Scaffold(
//       body: Text(
//         "NUMATOMA SUMA",
//         style: TextStyle(fontSize: 20),
//       ),
//       // body: StreamBuilder(
//       //   stream: document.where('userId', isEqualTo: currentUser).snapshots(),
//       //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       //     print("sveiki");
//       //     if (snapshot.connectionState == ConnectionState.waiting) {
//       //       return Center(
//       //         child: CircularProgressIndicator(),
//       //       );
//       //     }

//       //     if (snapshot.hasData) {
//       //       List list = [];
//       //       for (var item in snapshot.data.docs) {
//       //         list.add(item);
//       //       }

//       //       return ListView.separated(
//       //         itemCount: list.length,
//       //         separatorBuilder: (context, index) => const Divider(
//       //           thickness: 3,
//       //         ),
//       //         itemBuilder: (BuildContext context, int index) {
//       //           return Dismissible(
//       //             background: Container(color: Colors.red),
//       //             key: ValueKey(list.elementAt(index)),
//       //             confirmDismiss: (direction) async {
//       //               String propertyId = list[index]['propertyId'];
//       //               try {
//       //                 if (propertyId != '') {
//       //                   await FirebaseFirestore.instance
//       //                       .collection(firestoreProperty)
//       //                       .doc(propertyId)
//       //                       .update({'tenantId': ''});
//       //                 }
//       //                 await document.doc(list[index]['documentId']).delete();
//       //                 ScaffoldMessenger.of(context).showSnackBar(
//       //                   SnackBar(
//       //                     content: Text("Nuomininkas sėkmingai pašalintas."),
//       //                   ),
//       //                 );
//       //                 return true;
//       //               } catch (error) {
//       //                 ScaffoldMessenger.of(context).showSnackBar(
//       //                   SnackBar(
//       //                     content: Text("Įvyko klaida, bandykite dar karta"),
//       //                   ),
//       //                 );
//       //                 return false;
//       //               }
//       //             },
//       //             child: ListTile(
//       //               title: Text(
//       //                   "${list[index]['name']} ${list[index]['surname']}"),
//       //               subtitle: Text(list[index]['email']),
//       //               trailing: Text(list[index]['phoneNumber']),
//       //               onTap: () async {
//       //                 String documentId = list[index]['documentId'];
//       //                 await Navigator.push(
//       //                   context,
//       //                   MaterialPageRoute(
//       //                     builder: (context) =>
//       //                         TenantDetails(documentId: documentId),
//       //                   ),
//       //                 );
//       //               },
//       //             ),
//       //           );
//       //         },
//       //       );
//       //     } else {
//       //       return null;
//       //     }
//       //   },
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       // floatingActionButton: FloatingActionButton(
//       //   child: Icon(Icons.add),
//       //   onPressed: () async {
//       //     final message = await Navigator.push(
//       //       context,
//       //       MaterialPageRoute(
//       //         builder: (context) => AddTenant(),
//       //       ),
//       //     );
//       //     ScaffoldMessenger.of(context).showSnackBar(
//       //       SnackBar(content: Text(message)),
//       //     );
//       //   },
//       // ),
//     );
//   }
// }
