import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/screens/ui/count_colleted_payment.dart';
import 'package:baigiamasis/screens/ui/count_total_payment.dart';
import 'package:baigiamasis/screens/ui/count_uncollected_ammount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:printing/printing.dart';

class ShowReport extends StatelessWidget {
  final document = FirebaseFirestore.instance.collection(firestoreProperty);
  final currentMarketName =
      FirebaseFirestore.instance.collection(firestoreProperty);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(marketPlaceName),
        backgroundColor: Colors.blue[900],
        actions: [],
      ),
      // body: PdfPreview(
      //   build: (format) {
      //     _generatePdf(format, title),
      //   },
      // ),
      body: Column(
        children: [
          Container(
            height: 100,
            child: TotalAmmount(),
          ),
          Container(
            height: 100,
            child: CollectedPayment(),
          ),
          Container(
            height: 100,
            child: UncollectedPayment(),
          ),
        ],
      ),

      //======
      // body: Column(
      //   children: [
      //     Container(
      //       padding: const EdgeInsets.all(10),
      //       color: Colors.amber,
      //       child: Text(
      //         "NUMATOMA SUMA!!",
      //         style: TextStyle(fontSize: 20),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.symmetric(vertical: 12),
      //       child: TotalAmmount(),
      //     ),
      //     Expanded(
      //       child: StreamBuilder(
      //         stream: document
      //             .where('marketName', isEqualTo: marketName)
      //             .snapshots(),
      //         builder: (BuildContext context,
      //             AsyncSnapshot<QuerySnapshot> snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }

      //           if (snapshot.hasData) {
      //             var list = [];
      //             var data = snapshot.data.docs;
      //             data
      //                 .map((document) => {
      //                       list.add(
      //                         document.data(),
      //                       ),
      //                     })
      //                 .toList();

      //             //print('Data: ${list[0]['pavilion']}');
      //             collectedAmmount = [];
      //             totalAmount = 0;
      //             for (var item in list) {
      //               var ammountToPay = item['ammountToPay'];
      //               var toDouble = double.parse(ammountToPay);
      //               assert(toDouble is double);
      //               totalAmount += toDouble;
      //               print('Data: ${item['ammountToPay']}');

      //               for (var pay in item['payments']) {
      //                 if (pay['date'] == "2021-05-20") {
      //                   collectedAmmount.add(pay['ammount']);
      //                 }
      //               }
      //             }
      //             return Text(totalAmount.toString());
      //           } else {
      //             return Text(totalAmount.toString());
      //           }
      //         },
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
