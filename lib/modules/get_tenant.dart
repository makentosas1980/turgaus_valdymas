import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Set {
  String date;
  String ammount;

  Set(this.date, this.ammount);

  Map<String, dynamic> toMap() => {"date": this.date, "ammount": this.ammount};

  Set.fromMap(Map<dynamic, dynamic> map)
      : date = map["date"].toInt(),
        ammount = map["ammount"].toInt();
}

class Payment {
  List<dynamic> sets = [];

  Payment();

  Map<String, dynamic> toMap() => {"sets": this.sets};

  Payment.fromMap(Map<dynamic, dynamic> map)
      : sets = map['sets'].map((set) {
          return Set.fromMap(set);
        }).toList();
}

class GetTenant extends StatelessWidget {
  final String documentId;

  GetTenant(this.documentId);

  @override
  Widget build(BuildContext context) {
    final paymentt = FirebaseFirestore.instance.collection(firestoreProperty);
    if ((documentId) == '') {
      return Text('Nėra duomenų');
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future: paymentt.doc(documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Kažkas ne taip, bandykite dar kartą vėliau.");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            var paymentArray = data['payments'];

            if (paymentArray.length == 0) {
              return Text(
                "NUOMOS MOKESTIS NESUMOKĖTAS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              );
            }
            //sort array by date
            paymentArray.sort((a, b) {
              return a['date'].toString().compareTo(b['date'].toString());
            });
            //newest date comes first
            paymentArray = paymentArray.reversed.toList();
            var lastPaymentDate = "${paymentArray[0]['date']}";
            if (lastPaymentDate == currentDate) {
              return Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Text(
                  "NUOMOS MOKESTIS SUMOKĖTAS",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return Text(
                "NUOMOS MOKESTIS NESUMOKĖTAS",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    }
  }
}
// class GetTenant extends StatelessWidget {
//   final String paymentId;

//   GetTenant(this.paymentId);

// print('vakar');
// if ((paymentId) == '') {
//   return Text('Nėra duomenų');
// } else {
//   FirebaseFirestore.instance
//       .collection('payments')
//       .where('documentId', isEqualTo: paymentId)
//       .get()
//       .then((event) {
//     if (event.docs.isNotEmpty) {
//       //Map<String, dynamic> data = event.docs.single.data();
//       return Text("Status: "); //if it is a single document
//     } else {
//       return Text("koko");
//     }
//   });
//   return Text('Nėra duomenų');
//return Text('ok');
// return new StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection(firestorePayment)
//         .doc('6jcwiCByuwdVpdsgJY4b')
//         .snapshots(),
//     builder: (context, snapshot) {
//       if (!snapshot.hasData) {
//         return new Text("Loading");
//       }
//       var data = snapshot.data;
//       return new Text("Status: ${data['status']}");
//     });
//}

// class GetTenant extends StatelessWidget {
//   final String tenantId;

//   GetTenant(this.tenantId);

//   @override
//   Widget build(BuildContext context) {
//     final payment = FirebaseFirestore.instance.collection(firestorePayment);
//     if ((paymentId) == '') {
//       return Text('Nėra duomenų');
//     } else {
//       return FutureBuilder<DocumentSnapshot>(
//         future: payment.doc().get(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.hasError) {
//             return Text("Kažkas ne taip, bandykite dar kartą vėliau.");
//           }

//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data = snapshot.data.data();
//             print("data: $data");
//             return Text(
//               "a",
//               style: TextStyle(fontSize: 20),
//             );
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       );
//     }
//   }
// }
