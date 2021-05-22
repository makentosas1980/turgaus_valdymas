import 'package:baigiamasis/modules/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

double _totalAmount = 0;
var _collectedAmmount = [];

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
            padding: const EdgeInsets.all(10),
            color: Colors.amber,
            child: Text(
              "SURINKTA SUMA!!",
              style: TextStyle(fontSize: 20),
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

                  //print('Data: ${list[0]['pavilion']}');
                  _collectedAmmount = [];
                  _totalAmount = 0;
                  for (var item in list) {
                    for (var pay in item['payments']) {
                      if (pay['date'] == currentDate) {
                        _collectedAmmount.add(pay['ammount']);
                        var ammountToPay = item['ammountToPay'];
                        var toDouble = double.parse(ammountToPay);
                        assert(toDouble is double);
                        _totalAmount += toDouble;
                      }
                    }
                  }
                  print(_collectedAmmount);
                  print(_totalAmount);
                  return Text(_totalAmount.toString());
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
