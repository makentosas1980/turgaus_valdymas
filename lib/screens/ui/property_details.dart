import 'package:baigiamasis/modules/get_payment.dart';
import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/modules/rich_text.dart';
import 'package:baigiamasis/screens/ui/update_property.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PropertyDetails extends StatefulWidget {
  final String documentId;
  PropertyDetails({Key key, @required this.documentId}) : super(key: key);

  @override
  _PropertyDetailsState createState() => _PropertyDetailsState();
}

class _PropertyDetailsState extends State<PropertyDetails> {
  final document = FirebaseFirestore.instance.collection(firestoreProperty);

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
        stream: document
            .where('documentId', isEqualTo: widget.documentId)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                          height: 300,
                          child: GetPayment(
                            marketNameFoPayment: marketPlaceName,
                            pavilionForPayment: pavilion,
                            premiseNumberForPayment: premiseNumber,
                            ammountForPayment: ammountToPay,
                            documentId: widget.documentId,
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UpdateProperty(
                documentId: widget.documentId,
                pavilion: pavilion,
                premiseNumber: premiseNumber,
                ammountToPay: ammountToPay,
              ),
            ),
          );
        },
        label: Text('Redaguoti'),
      ),
    );
  }
}
