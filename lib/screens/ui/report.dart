import 'package:baigiamasis/screens/ui/preview_report.dart';
import 'package:flutter/material.dart';
import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/screens/ui/count_colleted_payment.dart';
import 'package:baigiamasis/screens/ui/count_total_payment.dart';
import 'package:baigiamasis/screens/ui/count_uncollected_ammount.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      ),
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 44,
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    overlayColor: MaterialStateProperty.all(Colors.blueAccent)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReportPreview('jap kap'),
                    ),
                  ).then(
                    (value) => ShowReport(),
                  );
                },
                child: Text('Spausdinti'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
