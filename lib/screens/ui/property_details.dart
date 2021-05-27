import 'package:baigiamasis/modules/get_tenant.dart';
import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/modules/print_receipt.dart';
import 'package:baigiamasis/modules/rich_text.dart';
//import 'package:baigiamasis/screens/ui/preview_receipt.dart';
//import 'package:baigiamasis/modules/update_property_details.dart';
import 'package:baigiamasis/screens/ui/update_property.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: unused_import
import 'package:intl/date_symbol_data_file.dart';

class PropertyDetails extends StatelessWidget {
  final document = FirebaseFirestore.instance.collection(firestoreProperty);
  final String documentId;
  PropertyDetails({Key key, @required this.documentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String pavilion;
    String premiseNumber;
    String ammountToPay;
    return Scaffold(
        appBar: AppBar(
          title: Text('NT informacija'),
        ),
        body: StreamBuilder(
          stream:
              document.where('documentId', isEqualTo: documentId).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData) {
              var data = [];
              for (var item in snapshot.data.docs) {
                data.add(item);
              }
              var property = data[0];
              isRentPaid = false;
              for (var payment in property['payments']) {
                if (currentDate == payment['date']) {
                  isRentPaid = true;
                }
              }
              pavilion = property['pavilion'];
              premiseNumber = property['premiseNumber'];
              ammountToPay = property['ammountToPay'];
              return Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichTextData(
                          labelTitle: 'Paviljonas: ',
                          labelData: pavilion,
                        ),
                        RichTextData(
                          labelTitle: 'Patalpų nr.: ',
                          labelData: premiseNumber,
                        ),
                        RichTextData(
                          labelTitle: 'Mokestis: ',
                          labelData: '$ammountToPay€',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 200,
                            color: Colors.green,
                            child: GetTenant(
                              documentId,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }

            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                heroTag: 'redaguoti',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProperty(
                        documentId: documentId,
                        pavilion: pavilion,
                        premiseNumber: premiseNumber,
                        ammountToPay: ammountToPay,
                      ),
                    ),
                  );
                },
                label: Text('Redaguoti'),
              ),
              Visibility(
                child: FloatingActionButton.extended(
                  heroTag: 'sumoketa',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PrintReceipt(
                                marketNametoPrint: marketPlaceName,
                                pavilionToPrint: pavilion,
                                premiseNumberToPrint: premiseNumber,
                                ammountToPayToPrint: '$ammountToPay€',
                                dateToPrint: currentDate,
                              )
                          //       // orderType: 'demo',
                          //       // orderNumber: '123456',
                          //       // customerName: 'John',
                          //       // deliveryTime: 'asap',
                          //       // instruction:
                          //       //     'Are you going to be able to print this one?',
                          //),
                          ),
                    );
                  },
                  label: Text('Sumokėti'),
                ),
              )
            ],
          ),
        ));
  }
}
