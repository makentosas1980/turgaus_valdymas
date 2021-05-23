import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

double _totalAmount = 0;
//var _collectedAmmount = [];

class CollectedPayment extends StatelessWidget {
  final document = FirebaseFirestore.instance.collection(firestoreProperty);
  final currentMarketName =
      FirebaseFirestore.instance.collection(firestoreProperty);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 40,
            child: Text(
              "SURINKTA SUMA",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: document
                  .where('marketName', isEqualTo: marketPlaceName)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasData) {
                  var list = [];
                  var data = snapshot.data.docs;
                  data
                      .map((document) => {
                            list.add(
                              document.data(),
                            ),
                          })
                      .toList();

                  _totalAmount = 0;
                  totalCollectedAmmount = 0;
                  for (var item in list) {
                    for (var pay in item['payments']) {
                      if (pay['date'] == currentDate) {
                        var ammountToPay = item['ammountToPay'];
                        var toDouble = double.parse(ammountToPay);
                        assert(toDouble is double);
                        _totalAmount += toDouble;
                        totalCollectedAmmount = _totalAmount;
                      }
                    }
                  }
                  return Container(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      '€$_totalAmount',
                      style: TextStyle(fontSize: 20, color: Colors.green),
                      textScaleFactor: 2.0,
                    ),
                  );
                } else {
                  return Text(_totalAmount.toString());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
