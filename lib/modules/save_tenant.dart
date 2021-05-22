// import 'package:baigiamasis/modules/globals.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// Future<String> createTenant(
//   String name,
//   String surname,
//   String phoneNumber,
//   String email,
//   String rentStart,
//   String rentEnd,
//   String propertyId,
// ) async {
//   User user = FirebaseAuth.instance.currentUser;
//   var document = FirebaseFirestore.instance.collection(firestoreTenant).doc();

//   try {
//     document.set(
//       {
//         'documentId': document.id,
//         'propertyId': propertyId,
//         'userId': user.uid,
//         'name': name,
//         'surname': surname,
//         'phoneNumber': phoneNumber,
//         'email': email,
//         'rentStart': rentStart,
//         'rentEnd': rentEnd,
//       },
//     );
//     var property = FirebaseFirestore.instance
//         .collection(firestoreProperty)
//         .doc(propertyId);
//     property.update({'tenantId': document.id});
//     property.update({'status': properStatusRented});

//     return AuthMessage.addTenantMessage;
//   } catch (e) {
//     return 'Įvyko klaida, bandykite dar karta';
//   }
// }
