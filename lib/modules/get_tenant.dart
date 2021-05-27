import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/modules/print_receipt.dart';
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

class GetPayment extends StatefulWidget {
  final String marketNameFoPayment;
  final String pavilionForPayment;
  final String premiseNumberForPayment;
  final String ammountForPayment;
  final String documentId;

  const GetPayment({
    Key key,
    this.marketNameFoPayment,
    this.pavilionForPayment,
    this.premiseNumberForPayment,
    this.ammountForPayment,
    this.documentId,
  }) : super(key: key);

  // GetPayment(this.documentId);

  @override
  _GetPaymentState createState() => _GetPaymentState();
}

class _GetPaymentState extends State<GetPayment> {
  @override
  Widget build(BuildContext context) {
    final paymentt = FirebaseFirestore.instance.collection(firestoreProperty);
    if ((widget.documentId) == '') {
      return Text('Nėra duomenų');
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future: paymentt.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text("Kažkas ne taip, bandykite dar kartą vėliau.");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data = snapshot.data.data();
            var paymentArray = data['payments'];
            if (paymentArray.length == 0) {
              //visiblePaymentButton = true;

            }
            //sort array by date
            paymentArray.sort((a, b) {
              return a['date'].toString().compareTo(b['date'].toString());
            });
            //newest date comes first
            paymentArray = paymentArray.reversed.toList();
            var lastPaymentDate = "${paymentArray[0]['date']}";
            if (lastPaymentDate == currentDate) {
              visiblePaymentButton = false;
              return Container(
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                width: 300,
                height: 300,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: Text(
                        "NUOMOS MOKESTIS SUMOKĖTAS",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                child: Column(
                  children: [
                    Text(
                      "NUOMOS MOKESTIS NESUMOKĖTAS",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: SizedBox(
                        width: double.infinity,
                        height: 44,
                        child: TextButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                              foregroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              overlayColor:
                                  MaterialStateProperty.all(Colors.blueAccent)),
                          onPressed: () {
                            print("popas: ${widget.premiseNumberForPayment}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PrintReceipt(
                                  marketNametoPrint: marketPlaceName,
                                  pavilionToPrint:
                                      widget.premiseNumberForPayment,
                                  premiseNumberToPrint:
                                      widget.premiseNumberForPayment,
                                  ammountToPayToPrint:
                                      '${widget.ammountForPayment}',
                                  dateToPrint: currentDate,
                                  documentId: widget.documentId,
                                ),
                              ),
                            );
                          },
                          child: Text('Sumokėti'),
                        ),
                      ),
                    ),
                  ],
                ),
              );

              // visiblePaymentButton = true;
              // return Column(
              //   children: [
              //     Text(
              //       "NUOMOS MOKESTIS NESUMOKĖTAS",
              //       style: TextStyle(
              //         fontSize: 20,
              //         color: Colors.red,
              //       ),
              //       textAlign: TextAlign.center,
              //     ),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(vertical: 20),
              //       child: SizedBox(
              //         width: double.infinity,
              //         height: 44,
              //         child: TextButton(
              //           style: ButtonStyle(
              //               backgroundColor:
              //                   MaterialStateProperty.all(Colors.blue),
              //               foregroundColor:
              //                   MaterialStateProperty.all(Colors.white),
              //               overlayColor:
              //                   MaterialStateProperty.all(Colors.blueAccent)),
              //           onPressed: () {
              //             print("labas");
              //           },
              //           child: Text('Sumokėti'),
              //         ),
              //       ),
              //     ),
              //   ],
              // );
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
