// import 'package:baigiamasis/modules/get_property.dart';
// import 'package:baigiamasis/modules/globals.dart';
// import 'package:baigiamasis/modules/rich_text.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// class TenantDetails extends StatelessWidget {
//   final document = FirebaseFirestore.instance.collection(firestoreTenant);
//   final String documentId;
//   TenantDetails({Key key, @required this.documentId}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     String name;
//     String surname;
//     String phoneNumber;
//     String email;
//     String rentStart;
//     String rentEnd;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Nuomininko informacija'),
//       ),
//       body: StreamBuilder(
//         stream: document.where('documentId', isEqualTo: documentId).snapshots(),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text("Something went wrong");
//           }

//           if (snapshot.hasData) {
//             var data = [];
//             for (var item in snapshot.data.docs) {
//               data.add(item);
//             }
//             var tenant = data[0];
//             name = tenant['name'];
//             surname = tenant['surname'];
//             phoneNumber = tenant['phoneNumber'];
//             email = tenant['email'];
//             rentStart = tenant['rentStart'];
//             rentEnd = tenant['rentEnd'];
//             return Padding(
//               padding: const EdgeInsets.only(top: 32),
//               child: Center(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RichTextData(
//                         labelTitle: 'Vardas: ',
//                         labelData: name,
//                       ),
//                       RichTextData(
//                         labelTitle: 'Pavardė: ',
//                         labelData: surname,
//                       ),
//                       RichTextData(
//                         labelTitle: 'Tel. nr.: ',
//                         labelData: phoneNumber,
//                       ),
//                       RichTextData(
//                         labelTitle: 'El. paštas: ',
//                         labelData: email,
//                       ),
//                       RichTextData(
//                         labelTitle: 'Nuomos pradžia: ',
//                         labelData: rentStart,
//                       ),
//                       RichTextData(
//                         labelTitle: 'Nuomos pabaiga: ',
//                         labelData: rentEnd,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: Container(
//                           alignment: Alignment.center,
//                           color: Colors.grey[300],
//                           child: Text('Nuomininkas'),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20),
//                         child: GetProperty(tenant['propertyId']),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {},
//         label: Text('Redaguoti'),
//       ),
//     );
//   }
// }
