import 'package:baigiamasis/modules/globals.dart';
import 'package:flutter/material.dart';

class PreviewReceipt extends StatefulWidget {
  final String marketNametoPrint;
  final String pavilionToPrint;
  final String premiseNumberToPrint;
  final String ammountToPayToPrint;
  final String dateToPrint;

  const PreviewReceipt({
    Key key,
    this.marketNametoPrint,
    this.pavilionToPrint,
    this.premiseNumberToPrint,
    this.ammountToPayToPrint,
    this.dateToPrint,
  }) : super(key: key);
  @override
  _PreviewReceiptState createState() => _PreviewReceiptState();
}

class _PreviewReceiptState extends State<PreviewReceipt> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        //alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          width: 300,
          height: 300,
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
                child: Text(widget.pavilionToPrint),
              ),
              Container(
                child: Text(widget.premiseNumberToPrint),
              ),
              Container(
                child: Text('Kaina: ${widget.ammountToPayToPrint}'),
              ),
              Container(
                child: Text(currentTime),
              ),
              Container(
                child: Text(currentDate),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
