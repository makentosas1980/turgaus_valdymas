import 'package:baigiamasis/modules/update_property_details.dart';
import 'package:baigiamasis/screens/ui/preview_receipt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_basic/flutter_bluetooth_basic.dart';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import 'globals.dart';

class PrintReceipt extends StatefulWidget {
  final String marketNametoPrint;
  final String pavilionToPrint;
  final String premiseNumberToPrint;
  final String ammountToPayToPrint;
  final String dateToPrint;
  final String documentId;

  const PrintReceipt({
    Key key,
    this.marketNametoPrint,
    this.pavilionToPrint,
    this.premiseNumberToPrint,
    this.ammountToPayToPrint,
    this.dateToPrint,
    this.documentId,
  }) : super(key: key);

  @override
  _PrintReceiptState createState() => _PrintReceiptState();
}

class _PrintReceiptState extends State<PrintReceipt> {
  _PrintReceiptState();
  PrinterBluetoothManager _printerManager = PrinterBluetoothManager();
  List<PrinterBluetooth> _devices = [];
  // ignore: unused_field
  String _devicesMsg;
  BluetoothManager bluetoothManager = BluetoothManager.instance;

  void initPrinter() {
    _printerManager.startScan(Duration(seconds: 2));
    _printerManager.scanResults.listen(
      (event) {
        if (!mounted) return;
        setState(() => _devices = event);

        if (_devices.isEmpty)
          setState(
            () {
              _devicesMsg = 'No devices';
            },
          );
      },
    );
  }

  @override
  void initState() {
    if (Platform.isIOS) {
      //initPrinter();
    } else {
      bluetoothManager.state.listen(
        (val) {
          if (!mounted) return;
          if (val == 12) {
            initPrinter();
          } else if (val == 10) {
            setState(() {
              _devicesMsg = 'Neaktyvuotas bluetooth';
            });
          }
        },
      );
    }
    super.initState();
  }

  Future<void> _startPrint(PrinterBluetooth printer) async {
    _printerManager.selectPrinter(printer);
    final myTicket = await _ticket(PaperSize.mm58);
    final result = await _printerManager.printTicket(myTicket);
    print(result);
  }

  Future<Ticket> _ticket(PaperSize paper) async {
    var _currentTime = new DateFormat('kk:mm:ss').format(DateTime.now());
    final ticket = Ticket(paper);
    ticket.text(_currentTime);
    ticket.text(currentDate);
    ticket.text(widget.marketNametoPrint);
    ticket.text(widget.pavilionToPrint);
    ticket.text(widget.premiseNumberToPrint);
    ticket.text(widget.ammountToPayToPrint);

    ticket.cut();
    return ticket;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pasirinkite spausdintuvą"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: _devices.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, position) => ListTile(
                  onTap: () async {
                    await _startPrint(_devices[position]);
                    addPayment(widget.documentId, currentDate,
                        widget.ammountToPayToPrint, true);
                  },
                  leading: Icon(Icons.print),
                  title: Text(_devices[position].name),
                  subtitle: Text(_devices[position].address),
                ),
                itemCount: _devices.length,
              )
            : Center(
                child: PreviewReceipt(
                  marketNametoPrint: widget.marketNametoPrint,
                  pavilionToPrint: widget.pavilionToPrint,
                  premiseNumberToPrint: widget.premiseNumberToPrint,
                  ammountToPayToPrint: widget.ammountToPayToPrint,
                  documentId: widget.documentId,
                ),
              ),
      ),
    );
  }
}
