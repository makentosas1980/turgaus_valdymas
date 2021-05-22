// import 'package:baigiamasis/modules/globals.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// // class Set {
// // String date;
// // String ammount;

// //   Set(this.date, this.ammount);

// //   Map<String, dynamic> toMap() => {
// //         "date": this.date,
// //         "ammount": this.ammount,
// //       };

// //   Set.fromMap(Map<dynamic, dynamic> map)
// //       : date = map["date"].toString(),
// //         ammount = map["ammount"].toString();
// // }

// // class PaymentList {
// //   List<dynamic> payments = [];

// //   PaymentList();

// //   Map<String, dynamic> toMap() => {"payments": this.payments};

// //   PaymentList.fromMap(Map<dynamic, dynamic> map)
// //       : payments = map['payments'].map((set) {
// //           return Set.fromMap(set);
// //         }).toList();
// // }

// // void readNestedData(documentid) {
// //     Exercise exercise;
// //     FirebaseFirestore.instance.collection(firestoreProperty).doc(documentid).get().then((docSnapshot) =>
// //     {
// //       payment = Exercise.fromMap(docSnapshot.data),
// //       payment.payments.forEach((set) {
// //         Set setInst = set as Set;
// //         print("date :" + setInst.date.toString());
// //       })
// //     });
// //   }

// class Set {
//   String date;
//   String ammount;

//   Set(this.date, this.ammount);

//   Map<String, dynamic> toMap() => {"date": this.date, "ammount": this.ammount};

//   Set.fromMap(Map<dynamic, dynamic> map)
//       : date = map["date"].toInt(),
//         ammount = map["ammount"].toInt();
// }

// class Payment {
//   List<dynamic> sets = [];

//   Payment();

//   Map<String, dynamic> toMap() => {"sets": this.sets};

//   Payment.fromMap(Map<dynamic, dynamic> map)
//       : sets = map['sets'].map((set) {
//           return Set.fromMap(set);
//         }).toList();
// }

// void readNestedData(documentId) {
//   Payment payment;
//   FirebaseFirestore.instance
//       .collection(firestoreProperty)
//       .doc(documentId)
//       .get()
//       .then((docSnapshot) => {
//             payment = Payment.fromMap(docSnapshot.data()),
//             payment.sets.forEach((set) {
//               Set setInst = set as Set;
//               print("=============");
//               print("date :" + setInst.date.toString());
//             })
//           });
// }
