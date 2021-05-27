import 'dart:typed_data';
import 'package:baigiamasis/modules/globals.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:baigiamasis/screens/ui/count_total_payment.dart';

var totalAmmountToPrint = TotalAmmount();

void main() => runApp(const ReportPreview('Printing Demo'));

class ReportPreview extends StatelessWidget {
  final String title;
  const ReportPreview(this.title);

  @override
  Widget build(BuildContext context) {
    print(totalAmmountToPrint.toString());
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
          title: Text(title),
        ),
        body: PdfPreview(
          build: (format) => _generatePdf(format, title),
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Padding(
                padding: pw.EdgeInsets.symmetric(vertical: 8),
                child: pw.Text(
                  'ATASKAITA',
                  style: pw.TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    'Visa surinktina suma',
                    style: pw.TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.topRight,
                child: pw.Text(
                  '$totalAmmount Eur',
                  style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    'Surinkta suma',
                    style: pw.TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.topRight,
                child: pw.Text(
                  '$totalCollectedAmmount Eur',
                  style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Container(
                  alignment: pw.Alignment.topLeft,
                  child: pw.Text(
                    'Surinkta suma',
                    style: pw.TextStyle(
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              pw.Container(
                alignment: pw.Alignment.topRight,
                child: pw.Text(
                  '$totalUncollectedAmmount Eur',
                  style: pw.TextStyle(
                    fontSize: 40,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Divider(),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Container(
                  alignment: pw.Alignment.center,
                  child: pw.Text(
                    '$currentDate       $currentTime',
                    style: pw.TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save();
  }
}
