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
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Text(
                  'Bendra suma: $totalAmmount Eur',
                  style: pw.TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Text(
                  'Bendra suma: $totalAmmount Eur',
                  style: pw.TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),
              pw.Container(
                child: pw.Text(
                  'Bendra suma: $totalAmmount Eur',
                  style: pw.TextStyle(fontSize: 40),
                ),
              ),
              pw.Padding(
                padding: pw.EdgeInsets.only(top: 40),
                child: pw.Text('ok'),
              ),
            ],
          );
          // return pw.Center(
          //   child: pw.Text(
          //     'Bendra suma: $totalAmmount',
          //     style: pw.TextStyle(fontSize: 40),
          //   ),
          // );
        },
      ),
    );

    return pdf.save();
  }
}
