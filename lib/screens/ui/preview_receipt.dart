import 'package:baigiamasis/modules/globals.dart';
import 'package:baigiamasis/modules/update_property_details.dart';
import 'package:flutter/material.dart';

class PreviewReceipt extends StatefulWidget {
  final String marketNametoPrint;
  final String pavilionToPrint;
  final String premiseNumberToPrint;
  final String ammountToPayToPrint;
  final String documentId;

  const PreviewReceipt({
    Key key,
    this.marketNametoPrint,
    this.pavilionToPrint,
    this.premiseNumberToPrint,
    this.ammountToPayToPrint,
    this.documentId,
  }) : super(key: key);
  @override
  _PreviewReceiptState createState() => _PreviewReceiptState();
}

class _PreviewReceiptState extends State<PreviewReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
          height: 400,
          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 48),
                child: Text(
                  'Nepavyko rasti spaudintuvo',
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 32),
                child: Text(
                  widget.marketNametoPrint,
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child:
                    Text('Paviljonas: ${widget.pavilionToPrint.toUpperCase()}'),
              ),
              Container(
                child: Text('Nr. ${widget.premiseNumberToPrint}'),
              ),
              Container(
                child: Text('Kaina: ${widget.ammountToPayToPrint}€'),
              ),
              Container(
                child: Text(currentTime),
              ),
              Container(
                child: Text(currentDate),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        overlayColor:
                            MaterialStateProperty.all(Colors.blueAccent)),
                    onPressed: () async {
                      await addPayment(widget.documentId, currentDate,
                          widget.ammountToPayToPrint, true);
                      visiblePaymentButton = false;
                      Navigator.pop(context);
                    },
                    child: Text('Patvirtinti mokėjimą'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
